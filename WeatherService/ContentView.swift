import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(alignment:.trailing) {
                CurrentWeather(viewModel: CurrentWeatherViewModel())
            }
        }
    }
}

#Preview {
    ContentView()
}
