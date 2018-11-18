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
                
                // Alert user of error
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    

    
        
        
        
        
//         -------------------------------
//        PASSWORDLESS VERIFICATION ATTEMPT
//         -------------------------------
        
//        let actionCodeSettings = ActionCodeSettings()
////        actionCodeSettings.url = URL(string: "https://www.example.com")
//        actionCodeSettings.url = URL(string: "1:119931782939:ios:51699fff2036a58e.firebaseapp.com")
//        // The sign-in operation has to always be completed in the app.
//        actionCodeSettings.handleCodeInApp = true
//        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
////        actionCodeSettings.setAndroidPackageName("com.example.android",
////                                                 installIfNotAvailable: false, minimumVersion: "12")
//
//        Auth.auth().sendSignInLink(toEmail:email, actionCodeSettings: actionCodeSettings) { error in
//            // ...
//            if let error = error {
////                self.showMessagePrompt(error.localizedDescription)
//                print("error: \(error)")
//                print("action code setting URL is: \(String(describing: actionCodeSettings.url))")
//                return
//            }
//            // The link was successfully sent. Inform the user.
//            // Save the email locally so you don't need to ask the user for it again
//            // if they open the link on the same device.
//            UserDefaults.standard.set(email, forKey: "Email")
////            self.showMessagePrompt("Check your email for link")
//            print("Check your email for link")
//            print("action code setting URL is: \(String(describing: actionCodeSettings.url))")
//            // ...
//        }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.hidesWhenStopped = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
