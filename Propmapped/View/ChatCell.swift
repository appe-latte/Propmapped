//
//  MessageCell.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 14/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet var MessageBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Refinements
        MessageBubble.layer.cornerRadius = MessageBubble.frame.size.height / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
