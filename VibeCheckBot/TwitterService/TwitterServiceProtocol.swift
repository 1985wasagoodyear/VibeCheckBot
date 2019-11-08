//
//  TwitterServiceProtocol.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

typealias TweetCompletion = (Result<Bool, TweetError>)->Void

protocol TwitterServiceProtocol {
    func signIn(_ vc: UIViewController, _ completion: @escaping (Bool)->Void)
    func postTweet(_ tweet: String, _ completion: @escaping TweetCompletion)
}
