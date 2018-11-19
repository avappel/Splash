//
//  ViewController.swift
//  CSE438-MatthewYang
//
//  Created by Matthew Yang on 11/5/18.
//  Copyright © 2018 Matthew Yang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var filterButton: UIButton!
    
    //117,201, 241
    let themeColor = UIColor.init(red: 0.4588, green: 0.78823, blue: 0.94509, alpha: 1)
    var currentLatitude = 38.6485577
    var currentLongitude = -90.311407
    var currentLocation: CLLocation!
    let locManager = CLLocationManager()
    
  
    
    var addingAnnotation = MKPointAnnotation()
    var isAddingPin = false
    var addingTitle = ""
    var addingSub = ""
    var addingLoc = CLLocationCoordinate2D()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locManager.requestWhenInUseAuthorization()
        
     
        
        //ADD BUTTON
        let infoButton = UIButton(type: .custom)
        infoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        infoButton.backgroundColor = themeColor
        infoButton.layer.cornerRadius = 10
        infoButton.layer.masksToBounds = false
        infoButton.layer.borderWidth = 0.8
        infoButton.layer.borderColor = themeColor.cgColor
        infoButton.layer.shadowOffset = CGSize(width: 0, height: 1.65)
        infoButton.layer.shadowOpacity = 0.7
        infoButton.layer.shadowRadius = 0
        infoButton.layer.shadowColor = UIColor.lightGray.cgColor

        let image = UIImage(named: "plus_white_625674.png")
        infoButton.setImage(image, for: .normal)

        infoButton.addTarget(self, action: #selector(toPinSelection), for: .touchUpInside)
        let infoItem = UIBarButtonItem(customView: infoButton)
       
        
   // let infoItem = UIBarButtonItem(title: "addButton", style: .done, target: self, action: #selector(logoutUser))
        
            navigationItem.rightBarButtonItems = [infoItem]
            navigationItem.rightBarButtonItem?.width = 24
        
        //PROFILE BUTTON
            let anotherButton = UIButton(type: .custom)
            anotherButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            anotherButton.setTitleColor(UIColor.white, for: .normal)
            anotherButton.backgroundColor = themeColor
            anotherButton.layer.cornerRadius = 10
            anotherButton.layer.masksToBounds = false
            anotherButton.layer.borderWidth = 0.8
            anotherButton.layer.borderColor = themeColor.cgColor
            anotherButton.layer.shadowOffset = CGSize(width: 0, height: 1.65)
            anotherButton.layer.shadowOpacity = 0.7
            anotherButton.layer.shadowRadius = 0
            anotherButton.layer.shadowColor = UIColor.lightGray.cgColor
        
//        anotherButton.addTarget(self, action: #selector(getter: UIDynamicBehavior.action), for: .touchUpInside)
//  let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutUser))
       // infoButton.addTarget(self, action: #selector(getter: UIDynamicBehavior.action), for: .touchUpInside)
        
       
        
            let image2 = UIImage(named: "account_white.png")
            anotherButton.setImage(image2, for: .normal)
        
            let infoItem2 = UIBarButtonItem(customView: anotherButton)
            navigationItem.leftBarButtonItems = [infoItem2]
        
        
            if CLLocationManager.locationServicesEnabled(){
                self.locManager.delegate = self
                self.locManager.desiredAccuracy = kCLLocationAccuracyBest
            
                self.locManager.startUpdatingLocation()
            }
        
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let location : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: false)
        
        //ANOTATIONS
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "DUC Bathroom"
            annotation.subtitle = "SIMON SUCKS"
            mapView.addAnnotation(annotation)
        
            let washULocation: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: currentLatitude, longitude: currentLongitude)
        
            let currentLocView = MKMapCamera.init(lookingAtCenter: washULocation, fromDistance: 100, pitch: 100, heading: 100)
            mapView.setCamera(currentLocView, animated: true)
    
        
//        if(isAddingPin){
//            mapView.addAnnotation(addingAnnotation)
//        }
        
    }//viewdidload
    //STILL NEED A DATABASE TO STORE PINS TO LOAD
    
    override func viewDidAppear(_ animated: Bool) {
        if(isAddingPin){
            addingAnnotation.title = addingTitle
            addingAnnotation.coordinate = addingLoc
            addingAnnotation.subtitle = addingSub
 
            mapView.addAnnotation(addingAnnotation)
        }
        isAddingPin = false //Deleted all details?
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let userLocation = locations.last
        currentLocation = userLocation //maybe this works?
        let viewRegion = MKCoordinateRegionMakeWithDistance((userLocation?.coordinate)!, 600, 600)
        self.mapView.setRegion(viewRegion, animated: false)
    }
    
    
    @objc func toPinSelection(){
        print("Segue to pin select")
        performSegue(withIdentifier: "SegueMapToPin", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "SegueMapToPin") {
                            let vc = (segue.destination as! SelectPinDetailsViewController)
                            vc.location = currentLocation.coordinate
                            print("To pin select; location = ")
                            print(currentLocation)
                        }
        
    }
    
//        override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject? ){
//            if(segue.identifier == "SegueMapToPin") {
//                let vc = (segue.destination as! SelectPinDetailsViewController)
//                vc.location = currentLocation.coordinate
//                print("To pin select; location = ")
//                print(currentLocation)
//            }
//
//        }//prepareforseeuge
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "SegueMapToDetails", sender: nil)//nil is incorret i think
    
        print("Pin pressed")
    }
    
    
    
  
    
    
    
//        if let location = locations.last{
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
//            mapView.setRegion(region, animated: true)
//        }
//        self.locManager.startUpdatingLocation()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}//class
// extension MapViewController{
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "SegueMapToPin") {
//            let vc = (segue.destination as! SelectPinDetailsViewController)
//            vc.location = currentLocation.coordinate
//            print("To pin select; location = ")
//            print(currentLocation)
//        }
//
//    }//prepareforseeuge
    
    
// }

//extension MKMapViewDelegate {
//    // 1 //gets calls for every view to return view annotations
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // 2 check if is artwork?
//       // guard let annotation = annotation as? Artwork else { return nil }
//        // 3
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        // 4
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
//}

//extension MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        performSegue(withIdentifier: "SegueMapToDetails", sender: nil)
//    }
//}
//
