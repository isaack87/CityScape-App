//
//  ContentModel.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/3/23.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {

    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restraunts = [Business]()
    @Published var sights = [Business]()

    // overriding init
    override init() {
        // running this over NSOject init
        super.init()
        // set content model as the delegate of location manager
        locationManager.delegate = self
        
        //request auth from user
       locationManager.requestWhenInUseAuthorization()


    }
    
    // MARK - Location Manager Delegate Methods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            // we have permissions
            // start geolocating user,  only if granted permission
            locationManager.startUpdatingLocation()

        }
        else if locationManager.authorizationStatus == .denied {
            // we dont have permissions
            print("denied")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // give us the location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
             
            //We have a location
            //Stop requestiong location after we get it
            locationManager.stopUpdatingLocation()
            
            // If we have corrs of the user, send to Yelp API
            getBusinesses(category: "arts", location: userLocation!)
            getBusinesses(category: "restaurants", location: userLocation!)
        }
        
        //TODO: get cororinates of user and use GPS loc to send to YELP API
        
        
        
    }

    
//    dataTask.resume()
//
    // MARK: - YELP API Methods
    
    func getBusinesses(category:String, location:CLLocation) {
        
        // create URL
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        // create URL request
        if let url = url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
      
        // Get URLSessions
        let session = URLSession.shared
        
        // Create data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
        // check if there isnt an error
            if error == nil {
                do {
                    // parse json
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(BusinessSearch.self, from: data!)
                    
                    // sort businesses
                    var businesses = result.businesses
                    businesses.sort{ (b1, b2) -> Bool in
                        return b1.distance ?? 0 < b2.distance ?? 0
                    }
                    
                    // call get image function
                    for b in result.businesses {
                        b.getImageData()
                    }
                    
                    DispatchQueue.main.async {
                        
                        switch category {
                        case Constants.sightsKey:
                            self.sights = businesses
                        case Constants.restaurantsKey:
                            self.restraunts = businesses
                        default:
                            break
                        }
                    }
                    print(result)
            
                } catch {
                    print(error)

                }
            }
        }
            // start data task
            dataTask.resume()
    }

    }
    
}
