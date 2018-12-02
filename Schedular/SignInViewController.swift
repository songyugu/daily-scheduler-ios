//
//  SignInViewController.swift
//  Schedular
//
//  Created by Songyu Gu on 12/1/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {

    
    var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self as? GIDSignInUIDelegate
        GIDSignIn.sharedInstance().signInSilently()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        signInButton = GIDSignInButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 100),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
  
}
