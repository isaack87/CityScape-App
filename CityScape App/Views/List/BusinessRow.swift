//
//  BusinessRow.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/11/23.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    
    var body: some View {
        
        
        VStack {
            HStack {
                
                // image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(15)
                    .scaledToFit()
                
                // name distnace
                VStack (alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text("\(calculateDistance(meter: business.distance ?? 0)) miles away")
                        .font(.caption)
                }
                Spacer()
                
                // star rating and number of reviews
                VStack(alignment: .leading) {
                    Image("regular_\(business.rating ?? 0.0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
                
            }
            DashDivider()
                .padding()
        }
        .foregroundColor(.black)
    }
    
}

