//
//  MainScreenVC.swift
//  SocialJoint
//
//  Created by Ethan Bonin on 11/16/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import UIKit
import FacebookCore
import SwifteriOS
import Accounts
import Social

class MainScreenVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    // handle to the Twitter API
    var swifter: Swifter?
    
    // Collection of Tweets
    var tweets: [Tweet] = []
    
    //Gradient Vairable for background
    var gradient : CAGradientLayer?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Start fetching Twitter home feed
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        let twitterAccounts = accountStore.accounts(with: accountType)!
        
        if twitterAccounts.isEmpty {
            self.alert(title: "Error", message: "Something went wrong. You should not have been able to get to this point without first adding a Twitter account from the settings menu.")
        } else {
            swifter = Swifter(account: twitterAccounts[0] as! ACAccount)
            self.swifter?.getHomeTimeline(count: 100, success: { json in
                for tweet in json.array! {
                    let text = tweet["text"].string!
                    let media_url = tweet["media"][0]["media_url_https"].string
                
                    self.tweets.append(Tweet(imageIncluded: media_url, tweetText: text))
                    self.collectionView.reloadData()
                }
            }, failure: { error in
                self.alert(title: "Error", message: "There was an error retrieving your Twitter feed.")
            })
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        //This sets the color of the background of the view.
        self.gradient = CAGradientLayer().IntroColor()
        self.gradient?.frame = self.view.bounds
        self.view.layer.insertSublayer(self.gradient!, at: 0)
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        
        cell.socialText.text = tweets[indexPath.row].tweet_text
        cell.socialText.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let image = UIImage(contentsOfFile: tweets[indexPath.row].img_url!)!
//        let maxSize = max(image.size.width, image.size.height)
//        let maxSizeNew = max(collectionView.bounds.width, collectionView.bounds.height) / 6
//        
//        let scale = maxSizeNew / maxSize
//        let newWidth = image.size.width * scale
//        let newHeight = image.size.height * scale
//        return CGSize(width: newWidth, height: newHeight)
//    }
}
