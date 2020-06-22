//
//  ChatMessage.swift
//  Propmapped
//
//  Created by Shami Kapoor on 18/06/20.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

public class ChatMessage : NSObject {
    
    public var author: String?
    public var id: String?
    public var isSame: String?
    public var message: String?
    public var otherUserImage: String?
    public var recepient_id: String?
    public var sender_id: String?
    public var timestamp: String?
    public var type: String?
    public var userImage: String?

    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [ChatMessage]
    {
        var models:[ChatMessage] = []
        for item in array
        {
            models.append(ChatMessage(dictionary: item as! NSDictionary)!)
        }
        return models
        
    }
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let User = User(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: User Instance.
     */
    required public init?(dictionary: NSDictionary) {
        author = dictionary["author"] as? String
        id = dictionary["id"] as? String
        isSame = dictionary["isSame"] as? String
        message = dictionary["message"] as? String
        otherUserImage = dictionary["otherUserImage"] as? String
        
        recepient_id = dictionary["recepient_id"] as? String
        sender_id = dictionary["sender_id"] as? String
        timestamp = dictionary["timestamp"] as? String
        type = dictionary["type"] as? String
        userImage = dictionary["userImage"] as? String
    }
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        return dictionary
    }
    
}

