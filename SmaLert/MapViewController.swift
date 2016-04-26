//
//  MapViewController.swift
//  SmaLert
//
//  Created by Kian on 4/10/16.
//  Copyright © 2016 Kian Sutarwala. All rights reserved.
//

import UIKit
import iAd

class MapViewController: UIViewController {
    
    var adForVC: UIViewController!
    
    ;override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        adForVC.canDisplayBannerAds = true
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

