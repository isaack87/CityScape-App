//
//  DirectionsMap.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/30/23.
//

import Foundation
import SwiftUI
import MapKit


struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var model : ContentModel
    var business: Business
    
    var start: CLLocationCoordinate2D {
        model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            return CLLocationCoordinate2D()
        }
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        // create map
        let map = MKMapView()
        map.delegate = context.coordinator
        
        // create directions requets
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // create directions object
        let directions = MKDirections(request: request)
        
        // calculate route
        directions.calculate { (response, error) in
            if error == nil && response != nil
            {
                // plot the rounte on map
                for route in response!.routes {
                    map.addOverlay(route.polyline)
                    
                    // zoom into region of user location
                    map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    // padding for map in directions/route view
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
                    
                }
            }
        }
        
        
        // here we place annotation for the end point on map directions route plot
        let annotationEnd = MKPointAnnotation()
        annotationEnd.coordinate = end
        annotationEnd.title = business.name ?? ""
        map.addAnnotation(annotationEnd)
        
        return map
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    // MARK - Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.lineWidth = 5
            renderer.strokeColor = .blue
            return renderer
        }
    }
}
