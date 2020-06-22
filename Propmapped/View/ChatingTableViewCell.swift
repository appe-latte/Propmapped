//
//  ChatingTableViewCell.swift
//  Propmapped
//
//  Created by Shami Kapoor on 18/06/20.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class ChatingTableViewCell: UITableViewCell {

    @IBOutlet weak var MessageBubble1: UIView!
    @IBOutlet weak var MessageBubble: UIView!
    @IBOutlet weak var senderImg: UIImageView!
    @IBOutlet weak var recieverImg: UIImageView!
//    @IBOutlet weak var mSenderTimeLbl: UILabel!
    @IBOutlet weak var mSenderLbl: UILabel!
//    @IBOutlet weak var mReciverTimeLbl: UILabel!
    @IBOutlet weak var mReciverLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
