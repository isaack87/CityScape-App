//
//  ContentView.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/3/23.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {

        // TODO: detect authorization status of geolocating user
        
        if (model.authorizationState == .notDetermined) {
            // if undetermined, show onboarding
            
            OnboardingView()
            
            
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            
            // if approved, show the dashboard.homeview
            HomeView()
        }
        else {
            // if denied sow denied view
            LocationDeniedView()

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
