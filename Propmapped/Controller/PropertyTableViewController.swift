//
//  PropertyTableViewController.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 10/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
class PropertyTableViewController : UITableViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var propertyImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var numberOfBedrooms: UILabel!
    @IBOutlet var propTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var shareButton: UIBarButtonItem!
    var ref: DatabaseReference!

    // Variables
    let loadingSpinner = LoadingSpinner();
    let fbh = FirebaseDownloadHelper();
    var property:Property?
    let cdh = CoreDataHelper();
    var isFav = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI();
        self.loadData();
        view.layer.cornerRadius = 15.0
    }
    
  func dismissAndPush(_ vc: UIViewController?) {
      dismiss(animated: false) {
          var mutableControllers: [UIViewController]? = nil
          if let viewControllers = self.navigationController?.viewControllers {
              mutableControllers = viewControllers
          }
          var controllers: [UIViewController]? = nil
          if let mutableControllers = mutableControllers, let vc = vc {
              controllers = mutableControllers + [vc]
          }
          if let controllers = controllers {
              self.navigationController?.setViewControllers(controllers, animated: false)
          }
      }

  }
    
    
    func createChat()
    {
        
        if let currentUser = Auth.auth().currentUser {
                   if let propertyUnwrapped = self.property {
                                 print("Current User: \(currentUser.uid)")
                       var bothID = [String]()
                let userID = currentUser.uid
                    
                    bothID.append(userID)
                   

                    
                    let reciverID = propertyUnwrapped.uniqueId ?? ""
                     bothID.append(reciverID)
                    let sortedValues = bothID.sorted { (value1, value2) in
                        let order = value1.compare(value2, options: .numeric)
                        return order == .orderedDescending
                    }
                    print(sortedValues)
                    let idNodes = sortedValues.joined(separator: "")
                    let occupant_id = sortedValues.joined(separator: ",")

                              self.ref = Database.database().reference()
                             

                   let chatHistory = self.ref.child("ChatHistory")
                     let bothIds = chatHistory.child(idNodes)
                     let unreadNode = bothIds.child("unread_message")
                     
                     let userData = bothIds.child("user_data")
                     
                     let unreadCountId1: Dictionary<String, Any> = ["unread_message_count":"","userid":currentUser.uid]
                     let unreadCountId2: Dictionary<String, Any> = ["unread_message_count":"","userid":propertyUnwrapped.user ?? ""]
                   
                    let userData1: Dictionary<String, Any> = ["user_image":"test1","user_name":currentUser.displayName ?? "User1","userid":currentUser.uid]
                    let userData2: Dictionary<String, Any> = ["user_image":"","user_name":propertyUnwrapped.title ?? "","userid":propertyUnwrapped.user ?? ""]
        
        let dict: NSDictionary = ["createTime": "\(ServerValue.timestamp())",
                                             "id": idNodes,
                                             "image":"",
                                             "last_message":"",
                                             "last_message_timeStamp":"\(ServerValue.timestamp())",
                                             "last_message_user_id":currentUser.uid,
                                             "name": "","occupant_id": occupant_id ?? "","type":""
        ]
                        bothIds.setValue(dict)
                          var unreadArray = [Dictionary<String, Any>?]()
                          unreadArray.append(unreadCountId1)
                          unreadArray.append(unreadCountId2)
                          unreadNode.setValue(unreadArray)
                          
                          var userArray = [Dictionary<String, Any>?]()
                          userArray.append(userData1)
                          userArray.append(userData2)
                          userData.setValue(userArray)
    }
        }}
    
    @IBAction func moveToChat(_ sender: Any) {
        self.createChat()
        if let currentUser = Auth.auth().currentUser {
            if let propertyUnwrapped = self.property {
                          print("Current User: \(currentUser.uid)")
                
                let   chatId = currentUser.uid + (propertyUnwrapped.uniqueId ?? "")
            let vc = UIStoryboard.init(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "NewChatVC") as? NewChatVC
                vc?.otherUserId = propertyUnwrapped.uniqueId ?? ""
                vc?.messageNode = String(chatId)
                vc?.userID = currentUser.uid
                vc?.otherUserName = propertyUnwrapped.user ?? ""
//                      vc.otherUserImage =
                present(vc ?? UIViewController(), animated: true)
//                self.dismissAndPush(vc)
                
            }
        }
               print("chat")
    }
    
    private func setUI() {
        
        self.loadingSpinner.showActivityIndicatory(uiView: self.view);
        if let propertyUnwrapped = self.property {
            self.titleLabel.text = propertyUnwrapped.title
            self.cityLabel.text = "City: \(propertyUnwrapped.city ?? "")"
            self.priceLabel.text = "Value: £\(propertyUnwrapped.valueUpTo ?? "")"
            self.numberOfBedrooms.text = "Bedrooms: \(propertyUnwrapped.numberOfBedrooms?.description ?? "")"
            self.descriptionLabel.text = "Description: \(propertyUnwrapped.propertyDescription ?? "")"
            self.propTypeLabel.text = "Property Type: \(propertyUnwrapped.propertyType ?? "")"
            cdh.fetchAllFavouriteProps()?.forEach({ (fav) in
                if fav.uniqueID == propertyUnwrapped.uniqueId {
                    // Favourite prop
                    self.isFav = true;
                }
            })
        }
    }
    
    private func loadData() {
        if let unwrappedID = self.property?.uniqueId {
            self.loadingSpinner.showActivityIndicatory(uiView: self.propertyImageView)
            fbh.downloadPropertyImage(uniqueRef: unwrappedID) { (data) in
                if let photoData = data {
                    self.propertyImageView.image = UIImage(data: photoData);
                    self.loadingSpinner.stopAnimatingIndicator();
                } else {
                    self.loadingSpinner.stopAnimatingIndicator();
                }
            }
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        if let propUnwrapped = self.property {
            self.shareActivity(propert: propUnwrapped)
        }
    }
    
    func shareActivity(propert:Property) {
        let shareText = "Hey, take a look at this property\n\n\(propert.title ?? "") I found using the PropMapped App!"
        var imageToShare = UIImage();
        
        if let image = UIImage(data:propert.photo ?? Data()) {
            imageToShare = image;
        }
        
        let vc = UIActivityViewController(activityItems: [shareText, imageToShare], applicationActivities: [])
        present(vc, animated: true)
    }
}
