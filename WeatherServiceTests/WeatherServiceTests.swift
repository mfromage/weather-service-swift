import XCTest
import Combine
import CoreLocation
@testable import WeatherService

final class WeatherServiceTests: XCTestCase {
    var weatherService: WeatherService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        
        weatherService = MockWeatherService()
        cancellables = []
    }

    override func tearDownWithError() throws {
        
        weatherService = nil
        cancellables = nil
    }

    func testGetCurrentWeatherSuccess() throws {
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let expectation = self.expectation(description: "Weather data fetched successfully")

        weatherService.getCurrentWeather(coordinate: coordinate)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got failure with \(error)")
                }
            }, receiveValue: { weather in
                
                XCTAssertEqual(weather.temp, MockWeatherService.weather.temp)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }
}
