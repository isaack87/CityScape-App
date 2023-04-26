//
//  BusinessMap.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/25/23.
//

//https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit

import Foundation
import MapKit
import SwiftUI

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model:ContentModel
    
    var locations: [MKAnnotation] {
        //create set of annotations from our list of business
        var annotations = [MKAnnotation]()
        
        for business in model.restraunts + model.sights {
            
            // if bussiness has lat/long coords and create MKpointAnnotation
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                // create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                annotations.append(a)
            }
            
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        // make user show on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // add the ones based on the business and add region
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordination: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
        
    }
}
