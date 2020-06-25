//
//  TableViewCell.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 28/08/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var userImg: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var msgLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        bgView.layer.borderColor = UIColor.black.cgColor
//        bgView.layer.borderWidth = 1
//        bgView.layer.cornerRadius = bgView.frame.height/2
//        bgView.clipsToBounds = true
        
//        userImg.layer.borderColor = UIColor.black.cgColor
//        userImg.layer.borderWidth = 1
//        userImg.layer.cornerRadius = userImg.frame.height/2
//        userImg.clipsToBounds = true
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
