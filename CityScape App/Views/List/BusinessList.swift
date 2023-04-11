//
//  BusinessList.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/10/23.
//

import SwiftUI

struct BusinessList: View {
    
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
      
        ScrollView(showsIndicators: false) {
            LazyVStack (alignment: .leading, pinnedViews: [.sectionHeaders]) {
                BusinessSection(title: "Restaurants", businesses: model.restraunts)
                BusinessSection(title: "Sights", businesses: model.sights)
            }
        }
        
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
