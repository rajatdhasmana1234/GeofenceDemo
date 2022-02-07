//
//  LocationManager.swift
//  GeofencingDemo
//
//  Created by RAJAT DHASMANA on 04/02/22.
//

import Foundation
import CoreLocation
import MapKit


class LocationManager: NSObject , ObservableObject {
    
    static var shared = LocationManager()
    
    private var locationManager = CLLocationManager()
    
    @Published var currentLocation : CLLocationCoordinate2D?
    @Published var currentRegion : MKCoordinateRegion = MKCoordinateRegion()
    @Published var checkInStatus : CheckInOut = .checkOut {
        didSet {
            print("checkIn status -> \(checkInStatus.rawValue)")
        }
    }
    
    
    override init() {
        super.init()
        
//        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestLocation()
        addGeofence()
        
        if let status = UserDefaults.standard.string(forKey: "status") {
            checkInStatus = CheckInOut(rawValue: status) ?? .checkOut
        }
    }
    
    private func addGeofence() {
        
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 28.5355, longitude: 77.3910), radius: 100, identifier: "Noida")
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            print("Geofencing is not supported on this device!")
            return
        }
        locationManager.startMonitoring(for: region)
    }
}


extension LocationManager : CLLocationManagerDelegate {
    
    
    
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//
//        print("entered \(region.identifier)")
//
//    }
    
}
