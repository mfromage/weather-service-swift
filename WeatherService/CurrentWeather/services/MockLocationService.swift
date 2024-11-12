import Foundation
import Combine
import CoreLocation

class MockLocationService: LocationService {
    func findLocations(query: String) -> AnyPublisher<[Location], Error> {
        let locations = [
            Location(
                id: 1,
                name: "Frankfurt",
                country: "Germany",
                coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
            ),
            Location(
                id: 2,
                name: "Berlin",
                country: "Germany",
                coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)
            )
        ]
        
        return Just(locations)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}