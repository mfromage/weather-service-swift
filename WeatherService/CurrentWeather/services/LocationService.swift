import Combine
import Foundation

protocol LocationService {
    func findLocations(query: String) ->  AnyPublisher<[Location], Error>
}

class GeonamesLocationService: LocationService {
    func findLocations(query: String) -> AnyPublisher<[Location], Error> {
        let key = ""
        guard let url = URL(string: "https://secure.geonames.org/searchJSON?q=\(query)&maxRows=5&username=\(key)") else {
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
            .decode(type: GeonamesLocationResponse.self, decoder: JSONDecoder())
            .map { $0.geonames }
            .eraseToAnyPublisher()
    }
}
