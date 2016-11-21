//
//  Tweet.swift
//  SocialJoint
//
//  Created by Eric Dattore on 11/20/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import Foundation

class Tweet {
    var img_url: String?
    var tweet_text: String
    
    init(imageIncluded img_url: String?, tweetText text: String) {
        self.img_url = img_url
        self.tweet_text = text
    }
}
