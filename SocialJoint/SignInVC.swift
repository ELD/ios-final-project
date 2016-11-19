//
//  SignInVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/16/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit
import FacebookLogin

class SignInVC: UIViewController, LoginButtonDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did log out of Facebook")
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
//        public enum LoginResult {
//            /// User succesfully logged in. Contains granted, declined permissions and access token.
//            case success(grantedPermissions: Set<Permission>, declinedPermissions: Set<Permission>, token: AccessToken)
//            /// Login attempt was cancelled by the user.
//            case cancelled
//            /// Login attempt failed.
//            case failed(Error)
//        }
        switch result {
        case .success(let granted, let declined, let token):
            print("Login successful")
        case .cancelled:
            print("Login cancelled")
        case .failed(let error):
            print("Login failed: \(error)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
