//
//  SignInVibeViewController.swift
//  VibeCheckBot
//
//  Created by K Y on 11/8/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import UIKit

class SignInVibeViewController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "logo")!
        let im = UIImageView(image: image)
        im.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(im)
        return im
    }()
    
    lazy var signInButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self,
                      action: #selector(signInAction),
                      for: .touchUpInside)
        btn.backgroundColor = .red
        btn.setTitle("Sign In To Check Vibes", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        return btn
    }()
    
    var service: TwitterServiceProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildConstraints()
    }
    
    func buildConstraints() {
        // image constraints
        let margin: CGFloat = 16.0
        let imConst = [
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,
                                               constant: margin),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: margin),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -margin),
            logoImageView.bottomAnchor.constraint(lessThanOrEqualTo: signInButton.topAnchor, constant: -margin)
        ]
        
        // button constraints
        let btnConst = [
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            signInButton.heightAnchor.constraint(equalToConstant: 60.0)
        ]
        
        NSLayoutConstraint.activate(imConst + btnConst)
    }

    @objc func signInAction() {
        service.signIn(self) { [weak self] (success) in
            guard let strongSelf = self else { return }
            if success {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vibeVC = storyboard.instantiateViewController(withIdentifier: "VibeViewController") as! VibeViewController
                vibeVC.service = strongSelf.service
                if #available(iOS 13, *) {
                    vibeVC.modalPresentationStyle = .fullScreen
                }
                strongSelf.present(vibeVC, animated: true, completion: nil)
            }
        }
    }

}
