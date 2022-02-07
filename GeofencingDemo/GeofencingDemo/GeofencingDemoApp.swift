//
//  GeofencingDemoApp.swift
//  GeofencingDemo
//
//  Created by RAJAT DHASMANA on 04/02/22.
//

import SwiftUI

@main
struct GeofencingDemoApp: App {
        
    @UIApplicationDelegateAdaptor var delegate: GeoAppDelegate

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
