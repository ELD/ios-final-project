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
    @IBOutlet var FBImageView: UIImageView!
    @IBOutlet var TwImageView: UIImageView!
    @IBOutlet var IGImageView: UIImageView!
    @IBOutlet var GPImageView: UIImageView!
    
    @IBOutlet var FBButtonChecked: UIButton!
    @IBOutlet var TwButtonChecked: UIButton!
    @IBOutlet var IGButtonChecked: UIButton!
    @IBOutlet var GPButtonChecked: UIButton!
    @IBOutlet var ContinueButton: UIButton!
    
    
    
    //VARIABLES//
    //This is to keep track of how many times Handle Tap occurs
    var introScreenTracker: Int = 0
    let aSelectorFirst : Selector = #selector(InitialSetUpVC.HandleFirstTap)
    var tapGesture = UITapGestureRecognizer()
    var gradient : CAGradientLayer?;
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        //This is set to false after IntroscreenTracker reaches 1
        view.isUserInteractionEnabled = true;
        
        tapGesture = UITapGestureRecognizer(target: self, action: aSelectorFirst)
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    func initialize() {
        
        //This sets all the buttons and Images to alpha 0, until IntroScreenTracker reaches 1
        if (introScreenTracker == 0 ){
            FBImageView.alpha = 0
            TwImageView.alpha = 0
            IGImageView.alpha = 0
            GPImageView.alpha = 0
            FBButtonChecked.alpha = 0
            TwButtonChecked.alpha = 0
            IGButtonChecked.alpha = 0
            GPButtonChecked.alpha = 0
            ContinueButton.alpha = 0
        }
        if (introScreenTracker == 1){
            
        }
        
    }
    
    //This sets up the first Gradient Layer to be created.
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
        if (introScreenTracker == 0) {
            introAnimateLayer()
            UIView.animate(withDuration: 3) {
                self.WelcomeLabel.alpha = 0
                if (self.WelcomeLabel.alpha == 0){
                    self.WelcomeLabel.text = "Where all Social Platforms Meet"
                    UIView.animate(withDuration: 5, animations: {
                        self.WelcomeLabel.alpha = 1
                        
                    })
                }
            }
        }
        
        if (introScreenTracker == 1) {
            secondAnimateLayer()
            UIView.animate(withDuration: 3) {
                self.WelcomeLabel.alpha = 0
                if (self.WelcomeLabel.alpha == 0){
                    self.WelcomeLabel.text = "Choose your Social Media"
                    UIView.animate(withDuration: 5, animations: {
                        self.WelcomeLabel.alpha = 1
                        self.FBImageView.alpha = 1
                        self.TwImageView.alpha = 1
                        self.IGImageView.alpha = 1
                        self.GPImageView.alpha = 1
                        self.FBButtonChecked.alpha = 1
                        self.TwButtonChecked.alpha = 1
                        self.IGButtonChecked.alpha = 1
                        self.GPButtonChecked.alpha = 1
                   
                    })
                }
            }
        }
        introScreenTracker = introScreenTracker + 1
    }
    
    
    @IBAction func FBButtonPressed(_ sender: Any) {
        print("FB button checked!")
        UIView.animate(withDuration: 3) {
            self.ContinueButton.alpha = 1
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
