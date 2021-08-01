import Foundation

class WeatherViewModel: NSObject {
    let weatherManager: WeatherNetworkProtocol = OpenWeatherNetworkManager()

    var temperature = Bindable<Int>(0)
    var temperatureFeelsLike = Bindable<Int>(0)

    public func getWeather() {
        let lat = "49.988358"
        let lon = "36.232845"

        weatherManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { [weak self] weather in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.updatedData(weather: weather)
            }
        }
    }

    private func updatedData(weather: WeatherModel) {
        temperature.value = weather.current.temp
        temperatureFeelsLike.value = weather.current.feelsLike
    }
}
