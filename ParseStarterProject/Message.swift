//
//  Message.swift
//  ParseStarterProject-Swift
//
//  Created by Craig Grummitt on 4/11/2015.
//  Copyright © 2015 Parse. All rights reserved.
//

import Parse

/**
 Describes the two chat participants and an array of messages.
 This is only relevant to Internet Games
 */
class Message: PFObject, PFSubclassing {
    @NSManaged var text:String
    
    static func parseClassName() -> String {
        return "Message"
    }
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}