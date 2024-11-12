import Foundation
import CoreLocation

struct GeonamesLocationResponse: Decodable {
    let totalResultsCount: Int
    let geonames: [Location]
}

struct Location: Identifiable, Decodable {
    let id: Int
    let name: String
    let country: String
    let coordinate: CLLocationCoordinate2D
    
    private enum CodingKeys: String, CodingKey {
        case id = "geonameId"
        case name
        case country = "countryName"
        case latitude = "lat"
        case longitude = "lng"
    }
    
    init(id: Int, name: String, country: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.country = country
        self.coordinate = coordinate
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
           
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        country = try container.decode(String.self, forKey: .country)

           
        let latitudeString = try container.decode(String.self, forKey: .latitude)
        let longitudeString = try container.decode(String.self, forKey: .longitude)
           
        guard let latitude = CLLocationDegrees(latitudeString),
                 let longitude = CLLocationDegrees(longitudeString) else {
               throw DecodingError.dataCorruptedError(forKey: .latitude,
                                                      in: container,
                                                      debugDescription: "Latitude or longitude could not be converted to Double")
        }
           
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
       }
}
