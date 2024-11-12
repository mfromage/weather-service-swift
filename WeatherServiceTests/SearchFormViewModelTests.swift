import XCTest
import Combine
@testable import WeatherService

final class SearchFormViewModelTests: XCTestCase {
    var viewModel: SearchFormViewModel!
    var submittedQuery: String?
    
    override func setUpWithError() throws {
        viewModel = SearchFormViewModel(onSubmit: { query in
            self.submittedQuery = query
        })
    }

    override func tearDownWithError() throws {
        viewModel = nil
        submittedQuery = nil
    }

    func testHandleSubmitPressWithEmptyQuery() throws {
        viewModel.query = ""
        viewModel.handleSubmitPress()
        XCTAssertEqual(viewModel.errorMessage, "Please type any city...")
        XCTAssertNil(submittedQuery)
    }

    func testHandleSubmitPressWithShortQuery() throws {
        viewModel.query = "Fr"
        viewModel.handleSubmitPress()
        XCTAssertEqual(viewModel.errorMessage, "Minimum 3 characters...")
        XCTAssertNil(submittedQuery)
    }

    func testHandleSubmitPressWithValidQuery() throws {
        viewModel.query = "Frankfurt"
        viewModel.handleSubmitPress()
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(submittedQuery, "Frankfurt")
    }
}
