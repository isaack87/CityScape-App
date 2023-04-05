//
//  CityScape_AppApp.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/3/23.
//

import SwiftUI

@main
struct CityScapeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
