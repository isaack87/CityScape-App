//
//  OnboardingView.swift
//  CityScape App
//
//  Created by Isaac Kim on 5/3/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var tabSelection = 0
    @EnvironmentObject var model:ContentModel
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        
        VStack {
            
            
            // tab view
            TabView(selection: $tabSelection) {
                
                // first tab
                VStack(spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City sights helps you find the best of the city")
                }
                .foregroundColor(.white)
                .tag(0)
                
                // second tab
                VStack(spacing: 20)
                {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover the city!")
                        .bold()
                        .font(.title)
                    Text("We will show you the best sights and venues around you")
                }
                .foregroundColor(.white)
                .tag(1)
                
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            // button
            
            Button {
                
                // detect which ta it is
                
                if tabSelection == 0 {
                    tabSelection = 1
                } else {
                    // request for geolocation
                    model.requestGeoLocationPermission()
                }
            } label: {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text( tabSelection == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                }
            }
            .accentColor(tabSelection == 0 ? blue : turquoise)
            .padding()
            Spacer()
        }
            .background(tabSelection == 0 ? blue : turquoise)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
