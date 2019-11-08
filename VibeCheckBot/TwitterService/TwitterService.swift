//
//  TwitterService.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit
import OAuthSwift
import KeychainAccess

private let serviceID = "ky.VibeCheckBot"
private let USER_HAS_SIGNED_IN_PREVIOUSLY = "userHasSignedInPreviously"

private extension URL {
    static let authorizeURL = URL(string: "\(Constants.scheme)://\(Constants.oauthcallback)/twitter")!
}

class TwitterService: TwitterServiceProtocol {
    
    // create an instance and retain it
    lazy var oauthswift: OAuth1Swift = {
        return OAuth1Swift(
            consumerKey:    "DmrkUypS1chPbqfA7SUHYnIOm",
            consumerSecret: "8UP4DSET1brhQ0UKupB27mNwm3O1NaaCPgVqWHAcSn2MewHjcH",
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
    }()
    
    var handle: OAuthSwiftRequestHandle?
    
    func signIn(_ vc: UIViewController,
                _ completion: @escaping (Bool)->Void) {
        
        if readFromKeychain() == true {
            print("user has already signed in")
            completion(false)
            return
        }
        print("User is signing in")
        // authorize
        let url: URL = .authorizeURL
        handle = oauthswift.authorize(
            withCallbackURL: url) { [weak self] result in
            switch result {
            case .success(let (credential, response, parameters)):
                guard let self = self else { return }
                let tokens = (oauthToken: credential.oauthToken,
                              oauthTokenSecret: credential.oauthTokenSecret)
                self.saveToKeychain(tokens)
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
        // oauthswift.authorizeURLHandler = SafariURLHandler(viewController: vc, oauthSwift: oauthswift)
    }
    
    private func saveToKeychain(_ tokens: (oauthToken: String, oauthTokenSecret: String)) {
        let keychain = Keychain(service: serviceID)
        keychain["oauthToken"] = tokens.oauthToken
        keychain["oauthTokenSecret"] = tokens.oauthTokenSecret
        
        let userDef = UserDefaults.standard
        userDef.set(true, forKey: USER_HAS_SIGNED_IN_PREVIOUSLY)
    }
    
    /// Represents existing token from previous signin
    func readFromKeychain() -> Bool {
        let userDef = UserDefaults.standard
        let hasSignedIn = userDef.bool(forKey: USER_HAS_SIGNED_IN_PREVIOUSLY)
        // user has never signed in before on this device
        // (or has logged out)
        if hasSignedIn == false {
            signout() // wipe data
            return false
        }
        let keychain = Keychain(service: serviceID)
        guard let oauthToken = keychain["oauthToken"],
            let oauthTokenSecret = keychain["oauthTokenSecret"] else {
                return false
        }
        oauthswift.client.credential.oauthToken = oauthToken
        oauthswift.client.credential.oauthTokenSecret = oauthTokenSecret
        return true
    }
    
    func signout() {
        let keychain = Keychain(service: serviceID)
        keychain["oauthToken"] = nil
        keychain["oauthTokenSecret"] = nil
        oauthswift.client.credential.oauthToken = ""
        oauthswift.client.credential.oauthTokenSecret = ""
    }
    
    func postTweet(_ tweet: String,
                   _ completion: @escaping (Result<Bool, TweetError>) -> Void) {
        guard var encoded = tweet.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.badTweet(tweet)))
            return
        }
        encoded = encoded.replacingOccurrences(of: "@", with: "%40")
        let updateEndpoint = URL(string:  "https://api.twitter.com/1.1/statuses/update.json?status=\(encoded)")!
        print(updateEndpoint)
        oauthswift.client.post(updateEndpoint) { (response) in
            switch response {
            case .success(let s):
                completion(.success(true))
            case .failure(let f):
                completion(.failure(.other(f)))
            }
        }
        
        
    }
    
    
}
