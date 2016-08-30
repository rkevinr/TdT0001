//
//  TDTActivityCell.swift
//  TDT
//
//  Created by Kevin on 8/29/16.
//  Copyright © 2016 R. Kevin Ryan. All rights reserved.
//

import UIKit

class TDTActivityCell: UITableViewCell {
    
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var activityDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
