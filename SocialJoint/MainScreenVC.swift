//
//  MainScreenVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/16/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit
import TwitterKit
import CircleMenu

extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
            green: Float(1.0) / Float(255.0) * Float(green),
            blue: Float(1.0) / Float(255.0) * Float(blue),
            alpha: alpha)
    }
}

class MainScreenVC: UIViewController, CircleMenuDelegate  {    
    let items: [(icon: String, color: UIColor)] = [
        ("icon_home", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
        ("icon_search", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
        ("notifications-btn", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
        ("settings-btn", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
        ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1)),
        ]
    
    //Gradient Vairable for background
    var gradient : CAGradientLayer?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This sets the color of the background of the view.
        self.gradient = CAGradientLayer().IntroColor()
        self.gradient?.frame = self.view.bounds
        self.view.layer.insertSublayer(self.gradient!, at: 0)
        
        // Cricle Menu button
        let menu = CircleMenu( frame: CGRect(x: self.view.center.x - 20, y: self.view.center.y - 20, width: 50, height: 50), normalIcon:"icon_menu", selectedIcon:"icon_menu", buttonsCount: 4, duration: 4,
distance: 120)
        menu.backgroundColor = UIColor.lightGray
        menu.delegate = self
        menu.layer.cornerRadius = menu.frame.size.width / 2.0
        view.addSubview(menu)
        
    }
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    
        if atIndex == 0 {
            showTimeline()
        } else if atIndex == 1{
            self.performSegue(withIdentifier: "showReddit", sender: self)
        } else if atIndex == 2 {
            accessFacebook()
        } else if atIndex == 3 {
            accessInstagram()
        }
        
    }
    

    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
    }
    
    
    func showTimeline() {
        let userId = Twitter.sharedInstance().sessionStore.session()?.userID
        // Create an API client and data source to fetch Tweets for the timeline
        let client = TWTRAPIClient(userID: userId)
        //TODO: Replace with your collection id or a different data source
//        let dataSource = TWTRCollectionTimelineDataSource(collectionID: "539487832448843776", apiClient: client)
        let dataSource = TWTRUserTimelineDataSource(screenName: nil, userID: userId, apiClient: client, maxTweetsPerRequest: 100, includeReplies: false, includeRetweets: false)
        // Create the timeline view controller
        let timelineViewControlller = TWTRTimelineViewController(dataSource: dataSource)
        // Create done button to dismiss the view controller
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissTimeline))
        timelineViewControlller.navigationItem.leftBarButtonItem = button
        // Create a navigation controller to hold the
        let navigationController = UINavigationController(rootViewController: timelineViewControlller)
        showDetailViewController(navigationController, sender: self)
    }
    
    func dismissTimeline() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func accessFacebook() {
        let appUrl = URL(string: "fb://")!
        let webUrl = URL(string: "https://facebook.com")!
        if UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
        } else {
            print("Can't open Facebook app")
            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        }
    }
    
    func accessInstagram() {
        let appUrl = URL(string: "instagram://app")!
        let webUrl = URL(string: "https://instagram.com")!
        if UIApplication.shared.canOpenURL(appUrl) {
            UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
        } else {
            print("Can't open Instagram app")
            UIApplication.shared.open(webUrl, options: [:], completionHandler: nil)
        }
    }    
}
