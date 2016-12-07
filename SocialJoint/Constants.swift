//
//  Constants.swift
//  SocialJoint
//
//  Created by Eric Dattore on 12/6/16.
//  Copyright © 2016 Ethan Bonin. All rights reserved.
//

import Foundation

class Constants {
    static let configFile = "app.plist"
    
    static func docFilePath(filename: String) -> String? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let dir = path[0] as NSString
        return dir.appendingPathComponent(filename)
    }
}
