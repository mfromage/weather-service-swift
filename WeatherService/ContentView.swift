//
//  ContentView.swift
//  WeatherService
//
//  Created by Michael Michael on 11.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment:.trailing) {
                SearchLocationView(viewModel: SearchLocationViewModel()) { _ in
                    
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
}
