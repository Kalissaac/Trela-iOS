//
//  HomeLocationViewController.swift
//  Trela
//
//  Created by Kalissaac on 6/21/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}

class HomeLocationViewController: UIViewController {
    
    var barFrame:CGRect?
    var typedAdress:String?
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func didTapSave(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if #available(iOS 9.0, *) {
            locationManager.requestLocation()
        } else {
            // Fallback on earlier versions
        }
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Type an adress"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.tabBarController?.tabBar.hidden=true
        if let tabBar=self.tabBarController?.tabBar {
            self.barFrame=tabBar.frame
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                let newBarFrame=CGRect(x: self.barFrame!.origin.x, y: self.view.frame.size.height, width: self.barFrame!.size.width, height: self.barFrame!.size.height)
                tabBar.frame=newBarFrame
                }, completion: { (Bool) -> Void in
                    tabBar.isHidden=true
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden=false;
        if self.barFrame != nil {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                let newBarFrame=CGRect(x: self.barFrame!.origin.x, y: self.view.frame.size.height-self.barFrame!.size.height, width: self.view.frame.size.width, height: self.barFrame!.size.height)
                self.tabBarController?.tabBar.frame=newBarFrame
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeLocationViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}

extension HomeLocationViewController: HandleMapSearch {
    func dropPinZoomIn(_ placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}
