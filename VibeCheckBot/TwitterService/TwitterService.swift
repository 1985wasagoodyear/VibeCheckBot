//
//  TwitterService.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit
import OAuthSwift

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
    
    private var token: String?
    private var tokenSecret: String?
    
    func signIn(_ vc: UIViewController) {
        // authorize
        let url = URL(string: "\(Constants.scheme)://\(Constants.oauthcallback)/twitter")!
        handle = oauthswift.authorize(
        withCallbackURL: url) { [weak self] result in
            switch result {
            case .success(let (credential, response, parameters)):
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                print(parameters["user_id"])
                guard let self = self else { return }
                self.token = credential.oauthToken
                self.tokenSecret = credential.oauthTokenSecret
            // Do your request
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // oauthswift.authorizeURLHandler = SafariURLHandler(viewController: vc, oauthSwift: oauthswift)
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
