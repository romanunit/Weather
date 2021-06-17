import Foundation

protocol WeatherNetworkProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (/*WeatherModel*/) -> ())
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (/*WeatherModel*/) -> ())
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping (/*[ForecastTemperature]*/) -> ())
}
