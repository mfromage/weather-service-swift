import Combine
import CoreLocation

protocol WeatherService {
    var id: String { get }
    var name: String { get }
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<Weather, Error>
}

