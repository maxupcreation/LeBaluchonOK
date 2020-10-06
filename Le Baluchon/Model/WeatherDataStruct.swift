

import Foundation

// MARK: - WeatherDataStruct
struct WeatherDataStruct: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
  
}
// MARK: - Main
struct Main: Decodable {
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case temp
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

