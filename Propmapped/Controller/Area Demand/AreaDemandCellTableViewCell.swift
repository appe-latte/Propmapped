//
//  AreaDemandCellTableViewCell.swift
//  Propmapped
//
//  Created by Stanford L. Khumalo on 25/01/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class AreaDemandCellTableViewCell: UITableViewCell {

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
