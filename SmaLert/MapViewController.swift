//
//  MapViewController.swift
//  SmaLert
//
//  Created by Kian on 4/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit
import iAd

class FirstViewController: UIViewController {
    
    var myViewController:UIViewController!
    
    ;override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myViewController.canDisplayBannerAds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

