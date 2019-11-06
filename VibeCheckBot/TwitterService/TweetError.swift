//
//  TweetError.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

enum TweetError: Error {
    /// represented as 403 from HTTP response
    case duplicate
    case badTweet(String)
    case other(Error)
}
