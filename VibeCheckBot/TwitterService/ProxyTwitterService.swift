//
//  ProxyTwitterService.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

// pretends to be twitter, lets us text our UI, application
// without actually using the Twitter website
// 1. mock returns
// 2. connect to our internal testing website
class ProxyTwitterService: TwitterServiceProtocol {
    func signIn(_ vc: UIViewController) {
        fatalError("Not implemented")
    }
    
    func postTweet(_ tweet: String,
                   _ completion: @escaping (Result<Bool, TweetError>) -> Void) {
        fatalError("Not implemented")
    }
}
