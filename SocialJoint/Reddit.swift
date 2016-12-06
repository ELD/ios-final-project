//
//  Tweet.swift
//  SocialJoint
//
//  Created by Eric Dattore on 11/20/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import Foundation

class Reddit {
    var title: String
    var author: String
    var link: String
    
    init(withTitle title: String, fromAuthor author: String, atUrl url: String) {
        self.title = title
        self.author = author
        self.link = url
    }
}
