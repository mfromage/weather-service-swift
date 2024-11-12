import SwiftUI
import Combine

class SearchLocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let locationService: LocationService
    
    init(locationService: LocationService = GeonamesLocationService()) {
        self.locationService = locationService
    }
    
    func searchLocations(query: String) {
        isLoading = true
        locationService.findLocations(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { locations in
                self.isLoading = false
                self.locations = locations
                self.errorMessage = locations.count == 0 ? "No locations found" : nil
            })
            .store(in: &cancellables)
    }
    
    func selectLocation(_ location: Location, onLocationSelected: (Location) -> Void) {
        onLocationSelected(location)
    }
}
