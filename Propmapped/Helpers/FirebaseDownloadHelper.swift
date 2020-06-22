//
//  FirebaseDownloadHelper.swift
//  Propmapped
//
//  Created by James Jamarsoft on 26/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class FirebaseDownloadHelper: NSObject {
    
    public func downloadPropertyImage(uniqueRef:String, completionBlock: @escaping (Data?) -> Void) -> Void {
        let storage = Storage.storage();
        let storageReference = storage.reference()
        
        if let currentUser = Auth.auth().currentUser {
            print("Current User: \(currentUser.uid)")
            let downloadPropertyRef = storageReference.child(Constants.FirebaseKeys.images).child(uniqueRef)
            downloadPropertyRef.getData(maxSize: 1 * 1024 * 10024) { (resultData, error) in
                if let data = resultData {
                    completionBlock(data)
                }
            }
        }
        completionBlock(nil)
    }
    
    public func downloadPropertyData(completionBlock: @escaping ([Property]?) -> Void) -> Void {
        let database = Database.database();
        let dbReference = database.reference()
        
        if let currentUser = Auth.auth().currentUser {
            print("Current User: \(currentUser.uid)")
            let downloadPropertyRef = dbReference.child(Constants.FirebaseKeys.users).child(Constants.FirebaseKeys.property)
            downloadPropertyRef.observe(.value, with: { snapshot in
                
                var newProps: [Property] = []
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let property = Property(snapshot: snapshot) {
                        newProps.append(property)
                    }
                }
                completionBlock(newProps)
            })
        }
        completionBlock(nil);
    }
}
