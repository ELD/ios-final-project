//
//  SignInVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/16/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit
import TwitterKit

class SignInVC: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Gradient Vairable for background
    var gradient : CAGradientLayer?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This sets the color of the background of the view.
        self.gradient = CAGradientLayer().IntroColor()
        self.gradient?.frame = self.view.bounds
        self.view.layer.insertSublayer(self.gradient!, at: 0)
        
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let filePath = Constants.docFilePath(filename: Constants.configFile)
                let data = NSMutableDictionary()
                data.addEntries(from: ["setup_done": true])
                data.write(toFile: filePath!, atomically: true)
                print("Written the plist")
                
                let alert = UIAlertController(title: "Logged In",
                                              message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: self.doSomething)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

    }
    
    
    func doSomething() {
       performSegue(withIdentifier: "mainMenuSegue", sender: nil)
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
