
import Foundation

// MARK: - WeatherDataStruct
struct WeatherDataStruct: Decodable {
    let list: [List]
}

// MARK: - List
struct List: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Decodable {
    let temp : Double

}


// MARK: - Weather
struct Weather: Decodable {
    let description : String
}
