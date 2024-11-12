import CoreLocation
import Combine

struct Current: Codable {
    let summary: String
    let temperature: Double
}

struct MeteoSourceWeatherResponse: Codable {
    let current: Current
}

class MeteoSourceWeatherService: WeatherService {
    var id: String = "meteo_source"
    
    var name: String = "MeteoSource"
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D) -> AnyPublisher<Weather, any Error> {
        let key = ""
        guard let url = URL(string: "https://www.meteosource.com/api/v1/free/point?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&units=metric&language=en&key=\(key)") else {
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
            .decode(type: MeteoSourceWeatherResponse.self, decoder: JSONDecoder())
            .map { Weather(temp: $0.current.temperature, summary: $0.current.summary) }
            .eraseToAnyPublisher()
    }
}
