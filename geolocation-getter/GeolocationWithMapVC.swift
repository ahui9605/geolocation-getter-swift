//
//  ViewController.swift
//  geolocation-getter
//
//  Created by Zehui Liu on 4/13/23.
//

import UIKit
import CoreLocation
import MapKit
class GeolocationWithMapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else{
            return
        }
        
        print("Current location: \(locationValue.latitude), \(locationValue.longitude)")
        
        latitude = String(locationValue.latitude)
        longitude = String(locationValue.longitude)
        
        labelLatitude.text = "Latitude: \(latitude)"
        labelLongitude.text = "Longitude: \(longitude)"
        
        // Set the map region to show the user's location
        let region = MKCoordinateRegion(center: locationValue, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)

        // Add a pin to the map at the user's location
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationValue
        annotation.title = "Current Location"
        mapView.addAnnotation(annotation)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the map view
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.frame = CGRect(x: 0, y: view.bounds.height / 2, width: view.bounds.width, height: view.bounds.height / 2)
        view.addSubview(mapView)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
