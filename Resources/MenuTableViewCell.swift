//
//  MenuTableViewCell.swift
//  TransparentView
//
//  Created by edwinbosire on 17/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    var menu: Menu {
        get {
            return self.menu
        }
        set {
            textLabel?.text = newValue.title
        }
    }
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textColor = UIColor.darkGray
        textLabel?.font = UIFont(name: "Raleway-Light", size: 40)
        textLabel?.textAlignment = .center
        backgroundColor = UIColor.clear
        selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            let titleWidth = textLabel?.intrinsicContentSize.width
            let separatorWidth:CGFloat = 240.0
            var ratio = (titleWidth! / separatorWidth)
            ratio += 0.2 * ratio // Add 20%
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions(), animations: { [unowned self] in
                self.separatorView.alpha = 1
                self.separatorView.transform = CGAffineTransform(scaleX: ratio, y: 1.0)

                }, completion: { finished in })
        }else {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions(), animations: { [unowned self] in
                self.separatorView.alpha = 0
                self.separatorView.transform = CGAffineTransform(scaleX: 0.2, y: 1.0)
                } , completion: { finished in })
        }
    }

}
