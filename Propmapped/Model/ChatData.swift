//
//  ChatData.swift
//  Propmapped
//
//  Created by Shami Kapoor on 18/06/20.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class ChatData: NSObject {
      public var createTime: String?
      public var id: String?
      public var last_message_timeStamp: String?
      public var last_message_user_id: String?
      public var occupant_id: String?
      public var type: String?

      
    public var user_data: [UserData]?

      /**
       Returns an array of models based on given dictionary.
       
       Sample usage:
       let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
       
       - parameter array:  NSArray from JSON dictionary.
       
       - returns: Array of User Instances.
       */
      public class func modelsFromDictionaryArray(array:NSArray) -> [ChatData]
      {
          var models:[ChatData] = []
          for item in array
          {
              models.append(ChatData(dictionary: item as! NSDictionary)!)
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
          print(dictionary)
          
          createTime = dictionary["createTime"] as? String
          id = dictionary["id"] as? String
          last_message_timeStamp = dictionary["last_message_timeStamp"] as? String
          last_message_user_id = dictionary["last_message_user_id"] as? String
          occupant_id = dictionary["occupant_id"] as? String
     if (dictionary["user_data"]) != nil{
         if (dictionary["user_data"]) is NSNull{
             return
         }
         user_data = UserData.modelsFromDictionaryArray(array: dictionary["user_data"] as! NSArray)
     }
          
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
public class UserData {
    
    public var user_image: String?
    public var user_name: String?
    public var userid: String?
  
    
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let User_list = User.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of User Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [UserData]
    {
        var models:[UserData] = []
        for item in array
        {
            models.append(UserData(dictionary: item as! NSDictionary)!)
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
        print(dictionary)
        
        user_image = dictionary["user_image"] as? String
        user_name = dictionary["user_name"] as? String
        userid = dictionary["userid"] as? String
    
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
