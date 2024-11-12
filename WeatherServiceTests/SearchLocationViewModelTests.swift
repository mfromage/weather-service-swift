import XCTest
import CoreLocation
import Combine
@testable import WeatherService

final class SearchLocationViewModelTests: XCTestCase {
    var viewModel: SearchLocationViewModel!
    var mockLocationService: MockLocationService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        mockLocationService = MockLocationService()
        viewModel = SearchLocationViewModel(locationService: mockLocationService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockLocationService = nil
        cancellables = nil
    }

    func testSearchLocationsSuccess() throws {
        let query = "Frankfurt"
        let expectation = self.expectation(description: "Locations fetched successfully")

        viewModel.$locations
            .dropFirst()
            .sink { locations in

                XCTAssertEqual(locations.count, MockLocationService.locations.count)
                XCTAssertEqual(locations.first?.name, MockLocationService.locations.first?.name)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchLocations(query: query)

        waitForExpectations(timeout: 5, handler: nil)
    }


    func testSelectLocation() throws {
        let location = Location(id: 11,
                                name: "Frankfurt",
                                country: "Germany",
                                coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060))
        var selectedLocation: Location?
        viewModel.selectLocation(location) { loc in
            selectedLocation = loc
        }

        XCTAssertEqual(selectedLocation?.name, "Frankfurt")
    }
}
