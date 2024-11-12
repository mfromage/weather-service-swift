import XCTest
import CoreLocation
import Combine
@testable import WeatherService

final class CurrentWeatherViewModelTests: XCTestCase {
    var viewModel: CurrentWeatherViewModel!
    var mockWeatherService: MockWeatherService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockWeatherService = MockWeatherService()
        viewModel = CurrentWeatherViewModel(weatherServices: [mockWeatherService])
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockWeatherService = nil
        cancellables = nil
    }

    func testSelectWeatherService() throws {
        let newWeatherService = MockWeatherService()

        viewModel.selectWeatherService(newWeatherService)

        XCTAssertEqual(viewModel.selectedWeatherService.id, MockWeatherService.defaultId)
    }

    func testSelectLocationAndFetchWeatherSuccess() throws {
        let location = Location(id: 11,
                                name: "Frankfurt",
                                country: "Germany",
                                coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060))
        let expectation = self.expectation(description: "Weather data fetched successfully")

        viewModel.$currentWeather
            .dropFirst()
            .sink { weather in
                
                XCTAssertEqual(weather?.temp, MockWeatherService.weather.temp)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.selectLocation(location)

        waitForExpectations(timeout: 5, handler: nil)
    }
}
