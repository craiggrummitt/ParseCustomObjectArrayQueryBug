//
//  Chat.swift
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
class Chat: PFObject, PFSubclassing {
    ///the following properties describe the chat
    @NSManaged var messages:[Message]
    
    static func parseClassName() -> String {
        return "Chat"
    }
    override var description:String {
        get {
            var returnValue:String = ""
            for message in messages {
                returnValue += message.text + "\r"
            }
            return returnValue
        }
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
