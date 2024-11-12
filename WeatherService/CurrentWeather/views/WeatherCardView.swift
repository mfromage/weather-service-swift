import SwiftUI

struct WeatherCardView: View {
    var name: String
    var temp: Double
    var summary: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(name)
                    .font(.title)
                Spacer()
                Text("\(temp, specifier: "%.1f")º")
                    .font(.title)
            }
            Text(summary)
        }
        .padding(16)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCardView(name: "Frankfurt", temp: 12.0, summary: "Clouds")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
