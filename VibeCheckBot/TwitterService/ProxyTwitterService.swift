//
//  ProxyTwitterService.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

// pretends to be Twitter, lets us text our UI, application
// without actually using the Twitter website
// 1. mock returns
// 2. connect to our internal testing website

private let PROXY_KEY = "proxyKey"

class ProxyTwitterService: TwitterServiceProtocol {
    
    private let userDef = UserDefaults.standard
    
    func signIn(_ vc: UIViewController,
                _ completion: @escaping (Bool) -> Void) {
        userDef.set(true, forKey: PROXY_KEY)
        completion(true)
    }
    
    func postTweet(_ tweet: String,
                   _ completion: @escaping (Result<Bool, TweetError>) -> Void) {
        completion(.success(true))
    }
    
    func readFromKeychain() -> Bool {
        return userDef.bool(forKey: PROXY_KEY)
    }
}
