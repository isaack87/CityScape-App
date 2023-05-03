//
//  DashDiivider.swift
//  CityScape App
//
//  Created by Isaac Kim on 5/3/23.
//

import SwiftUI

struct DashDivider: View {
    
    // create barrier dash line on home screen
    var body: some View {
        
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geometry.size.width , y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)
        }
        .frame(height: 1)
    }
}

struct DashDiivider_Previews: PreviewProvider {
    static var previews: some View {
        DashDivider()
    }
}
