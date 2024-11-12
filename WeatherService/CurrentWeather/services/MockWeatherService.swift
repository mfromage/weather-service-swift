import Foundation
import Combine
import CoreLocation

class MockWeatherService: WeatherService {
    static let defaultId = "mock"
    var id: String = defaultId
    var name: String = "Mock Weather Service"
    
    static let weather = Weather(temp: 12.0, summary: "Clouds")
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<Weather, Error> {
        
        
        return Just(Self.weather)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
