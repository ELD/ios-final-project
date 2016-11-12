//
//  InitialSetUpVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/11/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit

class InitialSetUpVC: UIViewController {
    
    
    // OUTLETS //
    @IBOutlet var WelcomeLabel: UILabel!
    @IBOutlet var BackGrounView: UIView!
    
    
    //VARIABLES//
    
    //This is to keep track of how many times Handle Tap occurs
    var introScreenTracker: Int = 0
    
    
    override func viewDidLoad() {
        BackGrounView.isUserInteractionEnabled = true;
        let aSelector : Selector = "HandleTap"
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        BackGrounView.addGestureRecognizer(tapGesture)
        
    }
    
    
    func HandleTap(){
        //When tapped the Animation fades out
        
        if (introScreenTracker == 0){
            UIView.animate(withDuration: 2) {
                self.WelcomeLabel.alpha = 0
                if (self.WelcomeLabel.alpha == 0){
                    self.WelcomeLabel.text = "Where all Social Platforms Meet \nOne Place"
                    UIView.animate(withDuration: 2, animations: {
                        self.WelcomeLabel.alpha = 1
                        self.introScreenTracker = self.introScreenTracker + 1
                    })
                }
            }
        }
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
