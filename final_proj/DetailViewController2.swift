//
//  DetailViewController2.swift
//  final_proj
//
//  Created by pruthvi raj dudam on 3/20/21.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController2: UIViewController, CLLocationManagerDelegate  {

    var manager:CLLocationManager!
    var myLat:Double?
    var mylon:Double?
    var rental_lat:Double?
    var rental_lon:Double?
    var selected_car3:String?
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    class func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                print("Something wrong with Location services")
                return false
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    //get my location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let userLocation:CLLocation = locations[0]
        self.myLat = userLocation.coordinate.latitude
        self.mylon = userLocation.coordinate.longitude
        print("my Latitude: \(myLat!)")
        print("my Longtitude: \(mylon!)")
        self.get_rental()
        self.getdir()
    }
    
    func getdir(){
        var lat = self.myLat!
        var lon = self.mylon!
        var rentalLat = self.rental_lat!
        var rentalLon = self.rental_lon!
        //let rental = Int.random(in: 0..<get_rental())
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)))
        source.name = "current location"
                
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: rentalLat, longitude: rentalLon)))
        destination.name = self.selected_car!
                
        MKMapItem.openMaps(
          with: [source, destination],
          launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
    
    func get_rental() -> [Double] {
        let request = MKLocalSearch.Request()
        var arr:[Double] = [2]
        request.naturalLanguageQuery = "car rental"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        for i in 0...arr.count{
            if i == 0{self.rental_lat = 33.342440}
            if i==1{self.rental_lon = -111.966500}}
        search.start { response, _ in
            guard let response = response else {
                return
            }
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            
            for i in 1...matchingItems.count - 1
            {
                    let place = matchingItems[i].placemark
                    print("latitude:",(place.location?.coordinate.latitude)!)
                      
                    print("longitude:",(place.location?.coordinate.longitude)!)

            }
        }
        return arr
    }
    
    
    
}
