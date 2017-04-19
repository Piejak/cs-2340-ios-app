//
//  ListCellTableViewCell.swift
//  WaterReport
//
//  Created by Hui Li on 4/17/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit

class ListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var waterTypeLabel: UILabel!
    @IBOutlet weak var waterConditionLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
