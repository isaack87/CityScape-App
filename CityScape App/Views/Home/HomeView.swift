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
            
            // determine if we show list or map view on homescreen
            if !isMapShowing {
                // show list
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "location")
                        Text("San Francisco")
                        Spacer()
                        Text("Switch Map/List Button")
                    }
                    Divider()
                    
                    BusinessList()
                }
                .padding([.horizontal, .top])
                
            } else {
                // show map
                
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
