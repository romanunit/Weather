import Foundation

class OpenWeatherNetworkManager {

    private enum Metrix {
        case standard
        case metric
        case imperial
    }

    private let apiKey = "0633afc4771c8d6c0b3b516a6ba8fae3"
    private let apiURL = "https://api.openweathermap.org"

    private func converDataToWeatherModel (data: OpenWeatherModel) -> WeatherModel {

        let current = Current(temp: Int(data.current.temp), feelsLike: Int(data.current.feelsLike))

        return WeatherModel(current: current)
    }
}

// MARK: - WeatherNetworkProtocol
extension OpenWeatherNetworkManager: WeatherNetworkProtocol {
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ()) {
        guard let url = URL(string: "\(apiURL)/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(Metrix.metric)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)

                //
                // Should return nil or error
                //
                completion(WeatherModel(current: Current(temp: -0, feelsLike: -0)))
            }

            if let data = data {
                //print(String(data: data, encoding: .utf8))

                do {
                    let openWeatherData = try JSONDecoder().decode(OpenWeatherModel.self, from: data)
                    //print(openWeatherData)

                    let weatherModel = self.converDataToWeatherModel(data: openWeatherData)
                    completion(weatherModel)
                } catch let currentError {
                    print(currentError)

                    //
                    // Should return nil or error
                    //
                    completion(WeatherModel(current: Current(temp: -0, feelsLike: -0)))
                }
            }

//            defer {
//                completion(WeatherModel(current: Current(temp: 1.0, feelsLike: 1.0)))
//            }

            //
            // Should return nil or error
            //
            //completion(WeatherModel(current: Current(temp: 1.0, feelsLike: 1.0)))

        }.resume()
    }
}
