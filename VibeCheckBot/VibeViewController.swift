//
//  VibeViewController.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

enum TweetError: Error {
    case duplicate // 403
    case other(Error)
}

typealias TweetCompletion = (Result<Bool, TweetError>)->Void

protocol TwitterServiceProtocol {
    func signIn()
    func postTweet(_ tweet: String, _ completion: TweetCompletion)
}

class TwitterService: TwitterServiceProtocol {
    
}

// pretends to be twitter, lets us text our UI, application
// without actually using the Twitter website
// 1. mock returns
// 2. connect to our internal testing website
class ProxyTwitterService:

class VibeViewController: UIViewController {
    
    @IBOutlet var vibeMessageLabel: UILabel!
    @IBOutlet var vibeTextField: UITextField!
    @IBOutlet var checkVibesButton: UIButton!
    
    let service: TwitterServiceProtocol = TwitterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func checkVibesAction(_ sender: Any) {
    }
}

