//
//  MapViewController.swift
//  GetGreen
//
//  Created by C4Q on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var greenMapView: MKMapView!
    @IBOutlet weak var greenSearchBar: UISearchBar!
    
    let notificationCenter = NotificationCenter.default
    var communityGardens: [CommunityGardens]? {
        didSet {
            loadAnnotations()
        }
    }
    
    let locationManager: CLLocationManager = {
        let locMan: CLLocationManager = CLLocationManager()
        locMan.desiredAccuracy = 100.0
        locMan.distanceFilter = 500.0
        return locMan
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        greenMapView.delegate = self
        greenSearchBar.delegate = self
        
    }
    
    @IBAction func refreshMap(_ sender: UIButton) {
        loadAnnotations()
    }
    override func viewDidAppear(_ animated: Bool) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let gardens = appDelegate.communityGardens {
            self.communityGardens = gardens
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(parseNotification(_:)),
                                               name: kGardensNotificationName,
                                               object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func parseNotification(_ notification: Notification) {
        if let gardens = notification.object as? [CommunityGardens] {
            self.communityGardens = gardens
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("All good")
            manager.startUpdatingLocation()
            //      manager.startMonitoringSignificantLocationChanges()
            
        case .denied, .restricted:
            print("NOPE")
            
        case .notDetermined:
            print("IDK")
            locationManager.requestWhenInUseAuthorization()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let validLocation: CLLocation = locations.last else { return }
        greenMapView.setRegion(MKCoordinateRegionMakeWithDistance(validLocation.coordinate, 500.0, 500.0), animated: true)
        let circleOverlay: MKCircle = MKCircle(center: validLocation.coordinate, radius: 50.0)
        greenMapView.add(circleOverlay)
        
    }
    func loadAnnotations() {
        
        if let validGardens = self.communityGardens {
            var annotations = [MKAnnotation]()
            
            for garden in validGardens {
                
                print(garden.address)
                let geocoder: CLGeocoder = CLGeocoder()
                geocoder.geocodeAddressString(garden.address, completionHandler: { (placemarks, error) in
                    print(error.debugDescription)
                    
                    if let validPlacemarks = placemarks,
                        let location = validPlacemarks.first?.location{
                        
                        let annotation = GetGreenAnnotation(location: location, garden: garden)
                        annotations.append(annotation)
                        DispatchQueue.main.async {
                            self.greenMapView.addAnnotation(annotation)
                        }
                    }
                })
            }
            
            
            validGardens.forEach({ (garden) in
                
                
                
            })
            //            print(annotations.count)
            //            greenMapView.addAnnotations(annotations)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation is MKUserLocation {
            return nil
        } else {
            let annotationIdentifier = "AnnotationIdentifier"
            let mapAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? AnnotationView ?? AnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            mapAnnotationView.canShowCallout = false
            mapAnnotationView.annotation = annotation
            
            
            
            let btn = UIButton(type: .detailDisclosure)
            mapAnnotationView.rightCalloutAccessoryView = btn
            mapAnnotationView.image = UIImage(named: "getgreenlogo")
            return mapAnnotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as! GetGreenAnnotation
        let garden = annotation.garden
        let placeName = garden.name
        let placeInfo = garden.address + "\n" + garden.neighborhood
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let annotation = view.annotation as! GetGreenAnnotation
        let garden = annotation.garden
        let placeName = garden.name
        let placeInfo = garden.address + "\n" + garden.neighborhood
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
class GetGreenAnnotation: NSObject, MKAnnotation{
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    let image = #imageLiteral(resourceName: "getgreenlogo")
    let garden: CommunityGardens
    
    init(location: CLLocation, garden: CommunityGardens) {
        self.coordinate = location.coordinate
        self.garden = garden
    }
}

class AnnotationView: MKAnnotationView {
    //    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    //        let hitView = super.hitTest(point, with: event)
    //        if (hitView != nil)
    //        {
    //            //self.superview?.bringSubview(toFront: self)
    //        }
    //
    //        return hitView
    //    }
    //    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    //        let rect = self.bounds;
    //        var isInside: Bool = rect.contains(point);
    //
    //        if(!isInside)
    //        {
    //            for view in self.subviews
    //            {
    //                isInside = view.frame.contains(point);
    //                if isInside
    //                {
    //                    break;
    //                }
    //            }
    //        }
    //        return isInside;
    //    }
}
