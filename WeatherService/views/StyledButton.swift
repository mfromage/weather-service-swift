import SwiftUI

struct StyledButton: View {
    var title: String
    var disabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(height: 40)
                .background(disabled ? .gray : .blue)
                .cornerRadius(12)
        }
        .disabled(disabled)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        StyledButton(title: "Press Me", action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
