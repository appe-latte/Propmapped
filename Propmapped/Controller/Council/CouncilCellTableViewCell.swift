//
//  CouncilCellTableViewCell.swift
//  Propmapped
//
//  Created by Stanford Khumalo on 20/01/2020.
//  Copyright © 2020 Propmapped. All rights reserved.
//

import UIKit

class CouncilCellTableViewCell: UITableViewCell {

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
