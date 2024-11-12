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
                CurrentWeather(viewModel: CurrentWeatherViewModel())
            }
        }
    }
}

#Preview {
    ContentView()
}
