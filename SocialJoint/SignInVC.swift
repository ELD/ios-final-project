//
//  SignInVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/16/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit
import FacebookLogin
import SwifteriOS
import Accounts
import Social

class SignInVC: UIViewController, LoginButtonDelegate {
    let CONSUMER_KEY = "pnjCX982Cipyeo6E1v71eL50i"
    let CONSUMER_SECRET = "5UjKqHXYlZ1TXzKOYkcOVacXvZakOYr8sHz4WQWIWlFhIohfgV"
    
    var swifter: Swifter
    
    required init?(coder aCoder: NSCoder) {
        self.swifter = Swifter(consumerKey: CONSUMER_KEY, consumerSecret: CONSUMER_SECRET)
        super.init(coder: aCoder)
    }

    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func twitterLoginWasClicked(_ sender: UIButton) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        // Prompt the user for permission to their twitter account stored in the phone's settings
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { granted, error in
            guard granted else {
                self.alert(title: "Error", message: error!.localizedDescription)
                return
            }
            
            let twitterAccounts = accountStore.accounts(with: accountType)!
            
            if twitterAccounts.isEmpty {
                self.alert(title: "Error", message: "There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
            } else {
                self.alert(title: "Success", message: "You have authorized this app to use your Twitter account. Please press the button below to continue.")
                self.nextButton.setTitle("Next", for: .normal)
            }
        }

    }
    
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        // Commented out for now since the Alpha release won't feature the Facebook sign-in option
//        view.addSubview(loginButton)
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did log out of Facebook")
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(let granted, let declined, let token):
            print("Login successful\ngranted: \(granted)\ndeclined: \(declined)\ntoken:\(token)")
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
