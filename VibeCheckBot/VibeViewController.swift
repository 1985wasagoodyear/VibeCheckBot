//
//  VibeViewController.swift
//  VibeCheckBot
//
//  Created by K Y on 11/6/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit




class VibeViewController: UIViewController {
    
    @IBOutlet var vibeMessageLabel: UILabel!
    @IBOutlet var vibeTextField: UITextField!
    @IBOutlet var checkVibesButton: UIButton!
    
    let service: TwitterServiceProtocol = TwitterService()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        service.signIn(self)
    }


    @IBAction func checkVibesAction(_ sender: Any) {
        guard let text = vibeTextField.text else { return }
        service.postTweet(text) { [weak self] (result) in
            switch result {
            case .success:
                print("Tweet posted")
            case .failure(let err):
                self?.handleFailure(err)
            }
        }
    }
    
    func handleFailure(_ failure: TweetError) {
        switch failure {
        case .duplicate:
            print("Duplicate tweet")
        case .badTweet(let tweet):
            print("was bad tweet: \(tweet)")
        case .other(let err):
            print("some other error occurred: \(err)")
        }
    }
}

