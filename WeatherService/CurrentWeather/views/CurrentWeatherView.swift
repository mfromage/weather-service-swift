import SwiftUI

struct CurrentWeather: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.weatherServices, id: \.id) { service in
                        Button(service.name) {
                            viewModel.selectWeatherService(service)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .tint(viewModel.selectedWeatherService.id == service.id ? .white : .blue)
                        .background(viewModel.selectedWeatherService.id == service.id ? .blue : .clear)
                        
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 1))
                    }
                }
            }
            
            SearchLocationView(
                viewModel: SearchLocationViewModel(),
                onLocationSelected: viewModel.selectLocation
            )
            
            if let weather = viewModel.currentWeather, let location = viewModel.selectedLocation {
                WeatherCardView(name: location.name, temp: weather.temp, summary: weather.summary)
                
            }
            
            if viewModel.isLoading {
                Text("Loading...")
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct CurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeather(viewModel: CurrentWeatherViewModel(weatherServices: [MockWeatherService(),MockWeatherService()]))
            .previewLayout(.sizeThatFits)
    }
}
