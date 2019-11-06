//
//  TwitterServiceProtocol.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

typealias TweetCompletion = (Result<Bool, TweetError>)->Void

protocol TwitterServiceProtocol {
    func signIn()
    func postTweet(_ tweet: String, _ completion: @escaping TweetCompletion)
}
