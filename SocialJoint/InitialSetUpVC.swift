//
//  InitialSetUpVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/11/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit

class InitialSetUpVC: UIViewController, CAAnimationDelegate {
    
    
    // OUTLETS //
    @IBOutlet var WelcomeLabel: UILabel!
    
    
    //VARIABLES//
    
    //This is to keep track of how many times Handle Tap occurs
    var introScreenTracker: Int = 0
    let aSelectorFirst : Selector = #selector(InitialSetUpVC.HandleFirstTap)
    let aSelectorSecond : Selector = #selector(InitialSetUpVC.HandleSecondTap)
    var tapGesture = UITapGestureRecognizer()
    
    
    var gradient : CAGradientLayer?;
    
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true;
        
        
        if (introScreenTracker == 0) {
            tapGesture = UITapGestureRecognizer(target: self, action: aSelectorFirst)
            view.addGestureRecognizer(tapGesture)
        }
        if (introScreenTracker == 1) {
            
            tapGesture = UITapGestureRecognizer(target: self, action: aSelectorSecond)
            view.addGestureRecognizer(tapGesture)
            
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.gradient = CAGradientLayer().IntroColor()
        self.gradient?.frame = self.view.bounds
        self.view.layer.insertSublayer(self.gradient!, at: 0)
    }
    
    func introAnimateLayer(){
        
        let fromColors = self.gradient?.colors
        
        let topColor = UIColor(red: (3/255.0), green: (75/255.0), blue: (110/255.0), alpha: 1)
        let bottomColor = UIColor(red: (95/255.0), green: (148/255.0), blue: (174/255.0), alpha: 1)
        
        let toColors: [AnyObject] = [topColor.cgColor, bottomColor.cgColor]
        self.gradient?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        //THIS PERFORMS THE TRANSITION
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 3.00
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.add(animation, forKey:"animateGradient")
    }
    
    func secondAnimateLayer() {
        
        let fromColors = self.gradient?.colors
        
        //TOP AND BOTTOM COLOR FOR FIRST TRANSITION
        let topColor = UIColor(red: (95/255.0), green: (148/255.0), blue: (174/255.0), alpha: 1)
        let bottomColor = UIColor(red: (195/255.0), green: (222/255.0), blue: (235/255.0), alpha: 1)
        
        let toColors: [AnyObject] = [topColor.cgColor, bottomColor.cgColor]
        self.gradient?.colors = toColors
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        
        //THIS PERFORMS THE TRANSITION
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 3.00
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.add(animation, forKey:"animateGradient")
        
        
    }
    
    
    func HandleFirstTap(){
        //When tapped the Animation fades out
        
        introAnimateLayer()
        UIView.animate(withDuration: 3) {
            self.WelcomeLabel.alpha = 0
            if (self.WelcomeLabel.alpha == 0){
                self.WelcomeLabel.text = "Where all Social Platforms Meet \nOne Place"
                UIView.animate(withDuration: 5, animations: {
                    self.WelcomeLabel.alpha = 1
                    
                })
            }
        }
        introScreenTracker = introScreenTracker + 1
        
        
    }
    
    
    func HandleSecondTap(){
        //When tapped the Animation fades out
        
        secondAnimateLayer()
        
        UIView.animate(withDuration: 3) {
            self.WelcomeLabel.alpha = 0
            if (self.WelcomeLabel.alpha == 0){
                self.WelcomeLabel.text = "Choose your Social Media\n that you would like to See"
                UIView.animate(withDuration: 5, animations: {
                    self.WelcomeLabel.alpha = 1
                    
                })
            }
        }
        introScreenTracker = introScreenTracker + 1
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
