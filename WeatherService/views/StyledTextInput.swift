import SwiftUI

struct StyledTextInput: View {
    @Binding var text: String
    var placeholder: String = ""
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(12)
            .frame(height: 40)
            .background(.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 0.5)
            )
            .autocorrectionDisabled(true)
    }
}

struct StyledTextInput_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        StyledTextInput(text: $text, placeholder: "Enter text")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
