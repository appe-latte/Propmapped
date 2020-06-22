//
//  StampTableViewCell.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 05/02/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class StampTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headLine: UILabel!
    @IBOutlet weak var subLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
