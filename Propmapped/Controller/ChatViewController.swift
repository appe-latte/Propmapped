//
//  ChatViewController.swift
//  Propmapped
//
//  Created by Shami Kapoor on 18/06/20.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ChatViewController: UIViewController {
    @IBOutlet var chatTable: UITableView!
    var ref: DatabaseReference!
       var userID = String()
    var chatList = [ChatData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = Auth.auth().currentUser {
            self.userID = currentUser.uid
            self.getChatHistory()

               }
        
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func getChatHistory(){
          
            //SVProgressHUD.show(withStatus: "Loading Chat")
            self.ref = Database.database().reference()
            self.ref.child("ChatHistory").observe(.value) { (snapShot) in
                print(snapShot)
                            if snapShot.value! is NSNull{
                            //    SVProgressHUD.dismiss()
                
                            }else{
                                let values = snapShot.value as? NSDictionary
                                print(values!)
                                self.chatList = [ChatData]()
                           //     self.chatobjectarray.removeAllObjects()
                              
                                for sort in snapShot.children{
                                    print(sort)
                                    let snap = sort as! DataSnapshot
                                    print(snap.key)
                                    let valueofKey = snap.value as! NSDictionary
                                    print(valueofKey)
                                    let occupId = valueofKey["occupant_id"] as? String
                                    let convertToArray = occupId?.components(separatedBy: ",")
                                    if (convertToArray?.contains(self.userID))!{
                                        print("yes")
                                       let chatDict = ChatData.init(dictionary: valueofKey)
                                        self.chatList.append(chatDict!)
                                    }
                                 //   let idOccu = valueofKey
                                   // self.chatobjectarray.add(snap.value!)
                                }
                
                           self.chatTable.reloadData()
                            }
        }
        
       }
}

    //MARK: Table Methods
    extension ChatViewController : UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if chatList.count > 0{
            return chatList.count
            }
            return 0
        }
        
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
            let chatListArray = chatList[indexPath.row]
            for i in 0..<chatListArray.user_data!.count{
                if chatListArray.user_data![i].userid! != userID{
                let ArrayUser = chatListArray.user_data![i]
                cell.userName.text = ArrayUser.user_name
                }
            }
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
           let chatListArray = chatList[indexPath.row]
            
            for i in 0..<chatListArray.user_data!.count{

                if chatListArray.user_data![i].userid! != userID{
                    let ArrayUser = chatListArray.user_data![i]
                    let destinationvc = UIStoryboard.init(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "NewChatVC") as? NewChatVC
                    destinationvc?.otherUserId = ArrayUser.userid!
                    destinationvc?.otherUserName = ArrayUser.user_name!
                    destinationvc?.otherUserImage = ArrayUser.user_image!
                    destinationvc?.messageNode = chatListArray.id ?? ""
                    self.present(destinationvc ?? UIViewController(), animated: true)
                    break
                }
        
            }
            
            
           
        
        
    }
}
    extension Dictionary where Value: Equatable {
        func containsValue(value : Value) -> Bool {
            return self.contains { $0.1 == value }
        }
    }





