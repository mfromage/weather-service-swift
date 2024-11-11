import SwiftUI

struct SearchFormView: View {
    @ObservedObject var viewModel: SearchFormViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 8) {
                StyledTextInput(text: $viewModel.query, placeholder: "Search city")
                    .disabled(viewModel.disabled)

                Button("Search") {
                    viewModel.handleSubmitPress()
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .tint(.white)
                .background(.blue)
                .cornerRadius(12)
                .disabled(viewModel.disabled)
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding(16)
    }
}

struct SearchForm_Previews: PreviewProvider {
    static var previews: some View {
        SearchFormView(viewModel: SearchFormViewModel(onSubmit: { query in
            print("Search for \(query)")
        }))
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
