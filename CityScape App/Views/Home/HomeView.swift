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
    @State var selectedBusiness:Business?
    
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
                    
                    ZStack(alignment: .top)  {
                        // show map
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                //create business detail view instance
                                //pass in selected business
                                BusinessDetail(business: business)
                            }
                            
                        // rectangle overlay here
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height:48)
                            
                            HStack {
                                Image(systemName: "location")
                                Text("San Francisco")
                                Spacer()
                                Button("Switch to list View") {
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .navigationBarHidden(true)
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
