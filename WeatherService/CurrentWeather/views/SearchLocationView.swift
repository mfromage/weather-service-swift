import SwiftUI

struct SearchLocationView: View {
    @ObservedObject var viewModel: SearchLocationViewModel
    var onLocationSelected: (Location) -> Void
    
    var body: some View {
        VStack {
            SearchFormView(viewModel: SearchFormViewModel(onSubmit: viewModel.searchLocations))
                
            if viewModel.isLoading {
                Text("Loading...")
            }
            VStack {
                ForEach(viewModel.locations) { location in
                    
                    HStack {
                        Text(location.name)
                        Spacer()
                        Text(location.country)
                    }
                    .padding(4)
                    .onTapGesture {
                        onLocationSelected(location)
                    }
                    .accessibility(identifier: SearchLocationTestId.listItem)
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray)
                }
            }
            .padding(.top, 8)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .accessibility(identifier: SearchLocationTestId.errorMessage)
            }
        }
    }
}

struct SearchLocation_Previews: PreviewProvider {
    static var previews: some View {
        SearchLocationView(
            viewModel: SearchLocationViewModel(locationService: MockLocationService()),
            onLocationSelected: { _ in }
        )
        .previewLayout(.sizeThatFits)
    }
}

struct SearchLocationTestId {
    static let list = "search-location-list"
    static let listItem = "search-location-list-item"
    static let errorMessage = "search-location-error-message"
}
