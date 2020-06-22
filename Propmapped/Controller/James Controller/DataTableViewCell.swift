//
//  DataTableViewCell.swift
//  Propmapped
//
//  Created by James 1DayLaunch on 01/12/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    
    @IBOutlet weak var headLine: UILabel!
    @IBOutlet weak var subLine: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
