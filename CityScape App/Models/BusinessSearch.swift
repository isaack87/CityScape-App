//
//  BusinessSearch.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/5/23.
//

import Foundation


struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}


