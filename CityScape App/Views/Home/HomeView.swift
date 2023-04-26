//
//  HomeView.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var isMapShowing = false
    
    var body: some View {

        
        if model.restraunts.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                // determine if we show list or map view on homescreen
                if !isMapShowing {
                    // show list
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Button("Switch to map View") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        BusinessList()
                            .ignoresSafeArea()
                    }
                    .padding([.horizontal, .top])
                    
                } else {
                    // show map
                    BusinessMap()
                        
                }
            }
        } else {
            //Spinner load if data hasnt been parsed and displayed
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
