import Foundation

protocol WeatherNetworkProtocol {
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
}
