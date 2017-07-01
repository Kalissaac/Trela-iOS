//
//  RalewayTableViewCell.swift
//  Trela
//
//  Created by Kian on 8/24/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class RalewayTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textLabel?.font = UIFont(name: "Raleway-Regular", size: UIFont.labelFontSize)
        self.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: UIFont.labelFontSize)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
