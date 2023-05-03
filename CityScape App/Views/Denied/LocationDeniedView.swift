//
//  LocationDeniedView.swift
//  CityScape App
//
//  Created by Isaac Kim on 5/3/23.
//

import SwiftUI

struct LocationDeniedView: View {
    
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack {

            Spacer()

            Text("Whoops!")
                .font(.title)

            Text(" We need to access your location to provide you with the best sights in the city. Please change your decision at any time in settings menu")

            Spacer()

            Button {
                
                // string allows user to enter setting to enable location
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                         // if we can open this setting url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }

            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)

                    Text("Go to settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                }
            }
            Spacer()
        }
        .multilineTextAlignment(.center)
        .background(backgroundColor)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
