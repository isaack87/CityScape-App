//
//  ContentView.swift
//  CityScape App
//
//  Created by Isaac Kim on 4/3/23.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}