//
//  ContentView.swift
//  WeatherService
//
//  Created by Michael Michael on 11.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SearchFormView(viewModel: SearchFormViewModel(onSubmit: handleSubmit))
        }
        .padding()
    }
    
    func handleSubmit(string: String) {
        
    }
}

#Preview {
    ContentView()
}
