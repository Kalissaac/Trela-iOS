//
//  AlertListTableViewCell.swift
//  Trela
//
//  Created by Kian on 8/19/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

class AlertListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.textLabel?.font = UIFont(name: "Raleway-Regular", size: 17)
        self.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
