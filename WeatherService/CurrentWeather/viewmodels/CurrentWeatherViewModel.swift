import SwiftUI
import Combine

class CurrentWeatherViewModel: ObservableObject {
    @Published var selectedWeatherService: WeatherService
    @Published var selectedLocation: Location?
    @Published var currentWeather: Weather?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    let weatherServices: [WeatherService]
    
    init(weatherServices: [WeatherService] = [OWWeatherService(), MeteoSourceWeatherService()]) {
        self.weatherServices = weatherServices
        self.selectedWeatherService = weatherServices[0]
    }
    
    func selectWeatherService(_ service: WeatherService) {
        selectedWeatherService = service
        fetchCurrentWeather()
    }
    
    func selectLocation(_ location: Location) {
        selectedLocation = location
        fetchCurrentWeather()
    }
    
    private func fetchCurrentWeather() {
        guard let location = selectedLocation else { return }
        
        isLoading = true
        selectedWeatherService.getCurrentWeather(coordinate: location.coordinate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { weather in
                self.currentWeather = weather
                self.errorMessage = nil
            })
            .store(in: &cancellables)
    }
}
