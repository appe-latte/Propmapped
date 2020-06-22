//
//  NewChatVC.swift
//  Propmapped
//
//  Created by Shami Kapoor on 18/06/20.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class NewChatVC:UIViewController {
    @IBOutlet weak var mChatingTableVw: UITableView!
    
    
    @IBOutlet weak var mHeaderLbl: UILabel!
    @IBOutlet weak var mTxt: UITextField!
    var chatArry: [ChatMessage]!
    var ref: DatabaseReference!
    var otherUserId = String()
    var otherUserName = String()

    var otherUserImage = String()
    var userID = String()
    var messageNode = String()
    var chatobjectarray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        chatArry = [ChatMessage]()
        mChatingTableVw.estimatedRowHeight = 200
        mChatingTableVw.rowHeight = UITableView.automaticDimension
//        userID = UserDefaults.standard.value(forKey: "LoginID") as? String ?? ""
//        if otherUserName != ""{
//            mHeaderLbl.text = otherUserName
//        }
        // Do any additional setup after loading the view.
        
//        mChatingTableVw.register(ChatingTableViewCell.self, forCellReuseIdentifier: "ChatingTableViewCellID")
//        mChatingTableVw.register(ChatingTableViewCell.self, forCellReuseIdentifier: "ChatingTableViewCellID2")

    }
    override func viewWillAppear(_ animated: Bool) {
        self.getChat()
    }
    @IBAction func mBackBtnAct(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func mSendBtnAct(_ sender: Any) {
        if mTxt.text != ""{
            sendMessage()
        }
    }
    func timestampToDate(Timestamp :Double,completion: (String) -> ()){
        let x = Timestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let localDate = formatter.string(from: date as Date)
        completion(localDate)
    }
    func timestampsToDate(Timestamp :String,completion: (String) -> ()){
        let x = Timestamp
        let date = NSDate(timeIntervalSince1970: (Double(x) as? TimeInterval)!)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let localDate = formatter.string(from: date as Date)
        completion(localDate)
    }
    func sendMessage(){
       
        self.ref = Database.database().reference()
        let messages = self.ref.child("Messages")
        let nodeFromID = messages.child(messageNode)
        let userID = self.userID
        let autoID = nodeFromID.childByAutoId()
        let occupant_id = self.userID + messageNode

        let date = Date()
        let new_timestamp = Int(date.timeIntervalSince1970 * 1000.0)
        let dict: NSDictionary = ["author": "Propmapped",
                                  "id":messageNode,
                                  "isSame":false,
                                  "message":mTxt.text!,
                                  "otherUserImage":otherUserImage,
                                  "recepient_id":otherUserId,
                                  "sender_id": userID,"timestamp": "\(new_timestamp)","occupant_id": occupant_id,"type":"text","userImage":""
        ]
        
        autoID.setValue(dict)
        mTxt.text! = ""
        self.getChat()
    }
    
    func getChat(){
        self.ref = Database.database().reference()
        print("messageNode---\(messageNode)"); self.ref.child("Messages").child(messageNode).queryOrdered(byChild: "timestamp").observe(.value, with: { (data) in
            print(data)
            
            if data.value! is NSNull{
          //      SVProgressHUD.dismiss()
                
            }else{
                let values = data.value as? NSDictionary
                print(values!)
                self.chatobjectarray.removeAllObjects()
                for sort in data.children{
                    print(sort)
                    let snap = sort as! DataSnapshot
                    self.chatobjectarray.add(snap.value!)
                }
                
                self.chatArry.removeAll()
                
                self.chatArry = ChatMessage.modelsFromDictionaryArray(array: self.chatobjectarray)
              //  SVProgressHUD.dismiss()
                self.mChatingTableVw.reloadData()
                self.scrollToBottom()
            }
        }) { (error) in
            print(error.localizedDescription)
            //  self.hideProgress()
        }
        
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatArry.count-1, section: 0)
            self.mChatingTableVw.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
extension NewChatVC: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if chatArry.count > 0{
        return chatArry.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let userID = Auth.auth().currentUser

        let chatArrId = chatArry[indexPath.row].sender_id
        print(chatArrId)
        print(String(describing: userID))
       if String(describing: chatArrId!) != String(describing: userID){
            let cell = mChatingTableVw.dequeueReusableCell(withIdentifier: "ChatingTableViewCellID", for: indexPath) as? ChatingTableViewCell
     

        cell?.mReciverLbl.text = chatArry[indexPath.row].message ?? ""
        cell?.MessageBubble.layer.cornerRadius = (cell?.MessageBubble.frame.size.height ?? 0) / 3

//        if let timeResult = chatArry[indexPath.row].timestamp  {
//            let date = Date(timeIntervalSince1970: Double(timeResult) as! TimeInterval)
//            let dateFormatter = DateFormatter()
//            dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
////            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
//            dateFormatter.timeZone = .current
//            let localDate = dateFormatter.string(from: date)
//            cell.mReciverTimeLbl.text! = localDate
//        }

        return cell ?? UITableViewCell()
       }else{
           let cell = mChatingTableVw.dequeueReusableCell(withIdentifier: "ChatingTableViewCellID2", for: indexPath) as? ChatingTableViewCell
             cell?.mSenderLbl.text = chatArry[indexPath.row].message ?? ""
//        if chatArry[indexPath.row].timestamp != ""{
//            _ = Double(chatArry[indexPath.row].timestamp!)
 
//            if let timeResult = Double(chatArry[indexPath.row].timestamp!) {
//                let date = Date(timeIntervalSince1970: timeResult / 1000)
//                let dateFormatter = DateFormatter()
//                dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
//                let localDate = dateFormatter.string(from: date)
//                cell.mSenderTimeLbl.text! = localDate
//            }
    
//        }
             cell?.MessageBubble1.layer.cornerRadius = (cell?.MessageBubble.frame.size.height ?? 0) / 3
            return cell ?? UITableViewCell()
          }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
}
