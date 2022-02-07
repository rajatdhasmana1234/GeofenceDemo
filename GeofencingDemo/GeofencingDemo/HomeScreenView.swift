//
//  HomeScreenView.swift
//  GeofencingDemo
//
//  Created by RAJAT DHASMANA on 04/02/22.
//

import SwiftUI
import MapKit

struct HomeScreenView: View {
    
    @State private var region = LocationManager.shared.currentRegion
    
    
//    let r = LocationManager.shared.currentLocation
    
    var body: some View {
        
//        NavigationView {
                
//            Map(coordinateRegion: .constant(MKCoordinateRegion()))
            
            Map(coordinateRegion: self.$region, interactionModes: .zoom, showsUserLocation: true, userTrackingMode: .constant(.follow))
            
            .navigationTitle(LocationManager.shared.checkInStatus.rawValue)
                .navigationBarTitleDisplayMode(.large)
//                .toolbar {
//
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button {
//                            print("plus tapped")
//                        } label: {
//                            Text("plus")
////                            Image("add")
//                        }
//                    }
//                }
//        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
