//
//  MapViewController.swift
//  Trela
//
//  Created by Kalissaac on 4/10/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import Presentr
import SWMessages
import ISHHoverBar


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, MenuViewDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    @IBOutlet weak var hoverBar: ISHHoverBar!
    
    var segmentedControl: DPSegmentedControl!

    @IBOutlet weak var googleAdBannerView: GADBannerView!
    
    ;override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        googleAdBannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        googleAdBannerView.rootViewController = self
        googleAdBannerView.loadRequest(GADRequest())
        
        let mapBarButton: UIBarButtonItem = MKUserTrackingBarButtonItem(mapView: self.mapView)
        let infoButton: UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        infoButton.addTarget(self, action: #selector(self.tapInfo(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let infoBarButton: UIBarButtonItem = UIBarButtonItem(customView: infoButton)
        self.hoverBar.items = [mapBarButton, infoBarButton]
        self.hoverBar.orientation = .Vertical
        self.hoverBar.tintColor = UIColor.init(hex: "#B60002")
        
        segmentedControl = DPSegmentedControl.init(
            FrameWithoutIcon: CGRectMake(307.5, 566, 235, 37.5),
            items: ["Standard", "Hybrid", "Satellite"],
            backgroundColor: UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1),
            thumbColor: UIColor.init(hex: "#B60002"),
            textColor: UIColor(hex: "#808080"),
            selectedTextColor: UIColor(hex: "#FFFFFF"))
        segmentedControl.alpha = 0
        
        segmentedControl.selectedIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(self.tapSegment(_:)), forControlEvents: .ValueChanged)
        self.view.insertSubview(self.segmentedControl, belowSubview: self.hoverBar)
        
        /*
         let location = LocalideGeoLocation(latitude: 37.776692, longitude: 0.0)
        Localide.sharedManager.promptForDirections(toLocation: location, { (usedApp, fromMemory, openedLinkSuccessfully) in
            print("The user picked \(usedApp.name)")
        })
        */
        
        /*
        func getDirections(){
            if let selectedPin = selectedPin {
                let mapItem = MKMapItem(placemark: selectedPin)
                let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMapsWithLaunchOptions(launchOptions)
            }
        }
        */
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.segmentedControl?.superview!.bringSubviewToFront(self.segmentedControl)
        self.hoverBar.superview!.bringSubviewToFront(self.hoverBar)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if !userDefaults.boolForKey("locationAsked") {
            
            let presenter: Presentr = {
            let presenter = Presentr(presentationType: .Alert)
            presenter.transitionType = .CoverVerticalFromTop // Optional
            return presenter
            } ()
            let titleText = "Can we access your location?"
            let bodyText = "This way we can show it on the map. We do not save or use your location for any other purpose."
            let controller = Presentr.alertViewController(title: titleText, body: bodyText)
            let noAction = AlertAction(title: "Nope", style: .Destructive) {
                userDefaults.setBool(false, forKey: "locationAsked")
                userDefaults.synchronize()
            }
            let okAction = AlertAction(title: "Sure!", style: .Cancel) {
                self.locationManager.requestWhenInUseAuthorization()
                userDefaults.setBool(true, forKey: "locationAsked")
                userDefaults.synchronize()
            }
            controller.addAction(noAction)
            controller.addAction(okAction)
            presenter.presentationType = .Alert
            customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapInfo(sender: AnyObject) {
        if segmentedControl.alpha == 1 {
            UIView.animateWithDuration(1, animations: {
                self.segmentedControl.alpha = 0
                self.segmentedControl.frame = CGRectMake( 307.5, 562, self.segmentedControl.frame.size.width, self.segmentedControl.frame.size.height );
            })
        } else {
            UIView.animateWithDuration(1, animations: {
                self.segmentedControl.alpha = 1
                self.segmentedControl.frame = CGRectMake( 60, 562, self.segmentedControl.frame.size.width, self.segmentedControl.frame.size.height );
            })
        }
    }
    
    func tapSegment(sender: DPSegmentedControl){
        if segmentedControl.selectedIndex == 0 {
            mapView.mapType = .Standard
        } else if segmentedControl.selectedIndex == 1 {
            mapView.mapType = .Hybrid
        } else if segmentedControl.selectedIndex == 2 {
            mapView.mapType = .Satellite
        } else { return }
    }
    
    @IBAction func didTapRefresh(sender: AnyObject) {
        self.loadView()
        self.mapView.reloadInputViews()
    }
    
    // MARK: - Ad Banner Delegate Methods
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        delay(2) {
            SWMessage.sharedInstance.showNotificationWithTitle( "Ad Error:", subtitle: "\(error.localizedDescription)", type: .Error )
        }
    }
    
    // MARK: - Location Delegate Methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated:true)
        self.locationManager.stopUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        delay(2) { 
            SWMessage.sharedInstance.showNotificationWithTitle( "Location Error:", subtitle: "\(error.localizedDescription)", type: .Error )
        }
    }
    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError) {
        delay(2) {
            SWMessage.sharedInstance.showNotificationWithTitle( "Location Error:", subtitle: "\(error.localizedDescription)", type: .Error )
        }
    }
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError) {
        delay(2) {
            SWMessage.sharedInstance.showNotificationWithTitle( "Map Error:", subtitle: "\(error.localizedDescription)", type: .Error )
        }
    }
    
    
    // MARK: - Menu Delegate
    
    lazy var menuViewController: MenuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("menu") as! MenuViewController
    var overlay: OverlayView?
    
    @IBAction func presentOverlay(sender: AnyObject) {
        
        menuViewController.delegate = self
        
        if overlay == nil {
            overlay = OverlayView()
        }
        
        overlay?.addSubview(menuViewController.view)
        overlay?.open()
    }
    
    func didSelect(menu: Menu, row: NSIndexPath, inTableView: UITableView) {
        
        self.title = menu.title;
        switch menu.title {
            
        case "Map":
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("Map")
            if let vc = viewController {
                displayContentController(vc)
            }
            break
            
        case "All Alerts" :
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("Alerts")
            if let vc = viewController {
                displayContentController(vc)
            }
            break
            
        case "More":
            
            let viewController = storyboard?.instantiateViewControllerWithIdentifier("More")
            if let vc = viewController {
                displayContentController(vc)
            }
            break
            
        case "":
            break
            
        case "Sign Out":
            let title = "Are you sure?"
            let body = "Do you really want to sign out?"
            let controller = Presentr.alertViewController(title: title, body: body)
            let deleteAction = AlertAction(title: "Sign Out", style: .Destructive) {
                try! FIRAuth.auth()?.signOut()
                let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginLogout")
                if let vc = viewController {
                    self.displayContentController(vc)
                }
            }
            let okAction = AlertAction(title: "Nope", style: .Cancel){ self.overlay?.dismissView() }
            controller.addAction(deleteAction)
            controller.addAction(okAction)
            let presenter = Presentr(presentationType: .Alert)
            customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
            self.navigationItem.title = "Trela"

            break
        default: break
            
        }
        overlay?.dismissView()
    }
    
    func displayContentController(content: UIViewController) {
        
        self.addChildViewController(content)
        content.view.frame = frameForContentController()
        self.view.addSubview(content.view)
        //TODO: Autolayout constraints go here
        content.didMoveToParentViewController(self)
    }
    
    func removeContentController(content: UIViewController) {
        
        content.willMoveToParentViewController(nil)
        //TODO: Remove any constraints that we configured withthe child's root view
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func frameForContentController() -> CGRect {
        return self.view.bounds
    }

}

/*
extension MapViewController : MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        if #available(iOS 9.0, *) {
            pinView?.pinTintColor = UIColor.orangeColor()
        } else {
            // Fallback on earlier versions
        }
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "directions"), forState: .Normal)
        button.addTarget(self, action: "getDirections", forControlEvents: .TouchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}
*/

extension UIColor {
    convenience init(hex:String) {
        let hexString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner            = NSScanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
