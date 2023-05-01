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
    @Binding var selectedBusiness: Business?
    
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
        
        //set as new instance of coordinator to display extra detail view upon clicking on pins
        mapView.delegate = context.coordinator
            
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
    
    // MARK - Coordinator class
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate  {
        
        var map: BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // if the annotation is the user blue dot, return nill
            if annotation is MKUserLocation {
                return nil
            }
            
            // check if there is a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationsReuseId)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationsReuseId)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            } else {
                // we got a reusable annotation
                annotationView!.annotation = annotation
            }
            
            // return it
            return annotationView
            
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            // User tapped on the annotation view
            
            // get business object annotation represents
            
            // map through businessList and match to selected annotation title
            
            for business in map.model.restraunts + map.model.sights {
                if (business.name ==  view.annotation?.title) {
                    
                    // set the selectedBusiness propery to that business object
                    map.selectedBusiness = business
                }
            }
            
           
            
            // set selectedBusiness property to business object
       
            
            
        }
    }
    
}
