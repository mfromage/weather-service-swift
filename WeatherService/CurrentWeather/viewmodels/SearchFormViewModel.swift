import SwiftUI
import Combine

class SearchFormViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var errorMessage: String?
    
    var onSubmit: (String) -> Void
    var disabled: Bool = false
    
    init(onSubmit: @escaping (String) -> Void, disabled: Bool = false) {
        self.onSubmit = onSubmit
        self.disabled = disabled
    }
    
    func handleSubmitPress() {
        if query.isEmpty {
            errorMessage = "Please type any city..."
        } else if query.count < 3 {
            errorMessage = "Minimum 3 characters..."
        } else {
            errorMessage = nil
            onSubmit(query)
        }
    }
}
