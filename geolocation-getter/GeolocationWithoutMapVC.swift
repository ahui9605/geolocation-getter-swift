//
//  GeolocationWithoutMapVC.swift
//  geolocation-getter
//
//  Created by Zehui Liu on 4/13/23.
//

import UIKit
import MapKit
import CoreLocation


class GeolocationWithoutMapVC: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var labelLongitude: UILabel!
    @IBOutlet weak var labelLatitude: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        
        // Print the user's current location coordinates
        print("Current location: \(locationValue.latitude), \(locationValue.longitude)")
               
        // Store the user's current location coordinates as strings
          latitude = String(locationValue.latitude)
          longitude = String(locationValue.longitude)
        
        // Update the latitude and longitude labels with the user's current location coordinates
        labelLatitude.text = "Latitude: \(latitude)"
        labelLongitude.text = "Longitude: \(longitude)"
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           // Handle location manager errors
           print("Location manager failed with error: \(error.localizedDescription)")
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Request authorization to use location services
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
    
        // Start updating the user's location
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }


}
