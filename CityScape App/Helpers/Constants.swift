//
//  Constants.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/5/23.
//

import Foundation

struct Constants {
    
    static var apiKey = "qmEKljLuXjE2gUlRww2aED62TDS1UyEW4f17gA-17uA6wYo0RmRww2O7lu6oVUilf-UDH_iBoc5AXbcah1CglZp50ECHUR-v0Bvhw2HKuXB4zb-Ywyrh9FguI-UtZHYx"
    static var apiUrl = "https://api.yelp.com/v3/businesses/search"
    static var restaurantsKey = "restaurants"
    static var sightsKey = "arts"
}

func calculateDistance(meter: Double) -> String {
    let meter = String(format: "%.1f", meter / 1609)
    return meter
}
