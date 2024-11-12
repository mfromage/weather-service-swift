import Foundation
import Combine
import CoreLocation

class MockWeatherService: WeatherService {
    var id: String = "mock"
    var name: String = "Mock Weather Service"
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<Weather, Error> {
        let weather = Weather(temp: 12.0, summary: "Clouds")
        
        return Just(weather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
