import XCTest
import Combine
@testable import WeatherService

final class LocationServiceTests: XCTestCase {
    var locationService: LocationService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        locationService = MockLocationService()
        cancellables = []
    }

    override func tearDownWithError() throws {
        locationService = nil
        cancellables = nil
    }

    func testFindLocationsSuccess() throws {
        let query = "Frankfurt"
        let expectation = self.expectation(description: "Locations fetched successfully")

        locationService.findLocations(query: query)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got failure with \(error)")
                }
            }, receiveValue: { locations in
                XCTAssertEqual(locations.count, MockLocationService.locations.count)
                XCTAssertEqual(locations.first?.name, MockLocationService.locations.first?.name)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)
    }
}

