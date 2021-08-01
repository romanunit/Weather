import Foundation

struct WeatherModel {
    let current: Current
}

struct Current {
    let temp: Int
    let feelsLike: Int
}
