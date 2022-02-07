//
//  GeoSceneDelegate.swift
//  GeofencingDemo
//
//  Created by RAJAT DHASMANA on 07/02/22.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class GeoSceneDelegate : NSObject , UIWindowSceneDelegate {
    
    let locationManager = CLLocationManager()
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print(#function)
    }
    
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print(#function)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print(#function)
        
    }
    
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print(#function)
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print(#function)
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        print(#function)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()

    }
}


extension GeoSceneDelegate : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        LocationManager.shared.currentLocation = manager.location?.coordinate
        if let loc = LocationManager.shared.currentLocation {
            LocationManager.shared.currentRegion = MKCoordinateRegion(center: loc, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
        
        guard let region = region else {
            print("Monitoring failed for unknown region")
            return
        }
        
        print("Monitoring failed for region with identifier: \(region.identifier)")
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didEnterRegion region: CLRegion
    ) {
        if region is CLCircularRegion {
            handleEvent(for: region, checkInStatus: .checkIn)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didExitRegion region: CLRegion
    ) {
        if region is CLCircularRegion {
            handleEvent(for: region, checkInStatus: .checkOut)
        }
    }
    
    func handleEvent(for region: CLRegion , checkInStatus : CheckInOut) {
        
        Api.hitDummyApi(successHandler: {
            
            DispatchQueue.main.async {
                UserDefaultsHelper.saveStatus(status: checkInStatus)
                NotificationHandler.createLocalNotificationForCheckInStatus(region: region, checkInStatus: checkInStatus)

            }
        })
    }
}



struct Api {
    
    static func hitDummyApi(successHandler : @escaping (() -> Void)) {
        
        let urlStr = "https://hub.dummyapis.com/vj/Hhs8H5k"
        guard let url = URL(string: urlStr) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            successHandler()
            
        }.resume()
    }
}



enum CheckInOut : String {
    case checkIn = "Checked In"
    case checkOut = "Checked Out"
}


struct NotificationHandler {
    
    static func createLocalNotificationForCheckInStatus(region: CLRegion , checkInStatus : CheckInOut) {
        
        let body : String
        let x = String(describing: LocationManager.shared.currentLocation?.latitude)

        switch checkInStatus {
        case .checkIn:
            
            
            body = "Checked in \(region.identifier) and current location is \(x)"
            
        case .checkOut:
            body = "Checked out of \(region.identifier) and current location is \(x)"

        }
        let notificationContent = UNMutableNotificationContent()
        notificationContent.body = body
        notificationContent.sound = .default
        notificationContent.badge = UIApplication.shared
            .applicationIconBadgeNumber + 1 as NSNumber
        // 3
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false)
        let request = UNNotificationRequest(
            identifier: "location_change",
            content: notificationContent,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
}
