//
//  CoreDataHelper.swift
//  Propmapped
//
//  Created by James Jamarsoft on 30/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper: NSObject {

        // Variables
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        func saveFavourtieProp(objectId:String) {
            let propEntity = NSEntityDescription.entity(forEntityName:Constants.CoreDataKeys.favProp, in: self.context)
            let prop = FavProp(entity: propEntity!, insertInto: context)
            prop.uniqueID = objectId;
            self.saveData()
        }
        
        func fetchAllFavouriteProps() -> [FavProp]? {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataKeys.favProp)
            let props: [FavProp]
            do {
                props = try context.fetch(fetchRequest) as! [FavProp]
                return props
            } catch {
                let fetchError = error as NSError
                print("\(fetchError), \(fetchError.userInfo)")
            }
            return nil
        }
        
        func findFavourite(ref:String) -> FavProp? {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreDataKeys.favProp)
            // Add Sort Descriptor
            fetchRequest.predicate = NSPredicate(format: "uniqueID == %@", ref)
            do {
                let results = try context.fetch(fetchRequest) as! [FavProp]
                return results.first
            } catch {
                let fetchError = error as NSError
                print("\(fetchError), \(fetchError.userInfo)")
            }
            return nil;
        }
        
        func deleteFavouriteProp(objectId:String) {
            if let vendor = self.findFavourite(ref: objectId) {
                context.delete(vendor);
                self.saveData()
            }
        }
        
        private func saveData() {
            do {
                try context.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
}
