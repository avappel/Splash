//
//  LoginViewController.swift
//  Splash
//
//  Created by Alex Appel on 11/9/18.
//  Copyright © 2018 Alex Appel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!

    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    @IBAction func handleLogin(_ sender: Any) {
        activityView.startAnimating()
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                self.activityView.stopAnimating()
                print("User signed in!")
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            } else {
                self.activityView.stopAnimating()
                print("Error signing in user: \(error!.localizedDescription)")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }

}
