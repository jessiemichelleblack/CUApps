//
//  MapViewController.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 7/28/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var place = Place()
    
    @IBAction func getDirections(sender: AnyObject) {
//        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
//            UIApplication.sharedApplication().openURL(NSURL(string:
//                "comgooglemaps://?center=" + latString + "," + longString + "&zoom=14&views=traffic")!)
//        } else {
//            print("Can't use comgooglemaps://");
//        }
        let customURL = "comgooglemaps://"
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: customURL)!) {
            UIApplication.sharedApplication().openURL(NSURL(string: customURL)!)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Google maps not installed", preferredStyle: UIAlertControllerStyle.Alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(ok)
            self.presentViewController(alert, animated:true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // 3
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        
        //----------------
        // Navigation Bar
        //----------------
        navigationController?.navigationBar.topItem!.title = "Engineering Center"
        navigationController?.navigationItem.title = "Engineering Center"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //called when a new location value is available
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
//        let span = MKCoordinateSpanMake(0.01, 0.01)
//        let region = MKCoordinateRegionMake(manager.location!.coordinate, span)
//        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(manager: CLLocationManager,didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("didchangeauth")
        if status==CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    //-----------------------------------
    // When location cannot be determined
    //-----------------------------------
    func locationManager(manager: CLLocationManager, didFailWithError
        error: NSError) {
        var errorType=String()
        if let clError=CLError(rawValue: error.code) {
            if clError == .Denied {
                errorType="access denied"
                let alert=UIAlertController(title: "Error", message:
                    errorType, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction:UIAlertAction=UIAlertAction(title: "OK",
                                                         style:UIAlertActionStyle.Default, handler: nil)
                alert.addAction(okAction)
                presentViewController(alert, animated: true, completion:
                    nil)
            }
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {

        let lat = CLLocationDegrees(place.latCoordinate)
        let long = CLLocationDegrees(place.longCoordinate)
        
        //-----------
        // Setup Map
        //-----------
        let location = CLLocationCoordinate2D(
            latitude: lat!,
            longitude: long!
        )
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        // Create annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate=location
        annotation.title = place.name
//        annotation.subtitle="Open: 7am - 8pm"
        mapView.addAnnotation(annotation)
        
        mapView.mapType=MKMapType.Standard
        let status:CLAuthorizationStatus =
            CLLocationManager.authorizationStatus()
        if status==CLAuthorizationStatus.NotDetermined{
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.distanceFilter=kCLDistanceFilterNone
        mapView.showsUserLocation=true
        
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
