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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func checkVibesAction(_ sender: Any) {
    }
}

