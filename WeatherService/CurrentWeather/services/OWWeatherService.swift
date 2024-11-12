import CoreLocation
import Combine

struct WeatherDescription: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
}

struct OWWeatherResponse: Codable {
    let weather: [WeatherDescription]
    let main: Main
}

class OWWeatherService: WeatherService {
    var id: String = "open_weather"
    
    var name: String = "OpenWeather"
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<Weather, any Error> {
        let key = ""
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=metric&appid=\(key)") else {
            return Fail(error: URLError(.badURL))
                   .eraseToAnyPublisher()
           }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: OWWeatherResponse.self, decoder: JSONDecoder())
            .map { Weather(temp: $0.main.temp, summary: $0.weather.first?.description ?? "Unknown") }
            .eraseToAnyPublisher()
    }
}
