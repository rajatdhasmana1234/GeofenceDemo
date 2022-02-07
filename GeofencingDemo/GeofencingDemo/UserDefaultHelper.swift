//
//  UserDefaultHelper.swift
//  GeofencingDemo
//
//  Created by RAJAT DHASMANA on 07/02/22.
//

import Foundation


struct UserDefaultsHelper {
    
    static func saveStatus(status: CheckInOut) {
        
        switch status {
        case .checkIn:
            UserDefaults.standard.set("Checked In", forKey: "status")
            
        case .checkOut:
            UserDefaults.standard.set("Checked Out", forKey: "status")
        }
        LocationManager.shared.checkInStatus = status
    }
}
