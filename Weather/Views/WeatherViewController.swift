import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var requestBtn: UIButton?
    @IBOutlet weak var currentTemperature: UILabel?
    @IBOutlet weak var feelsLikeTemperature: UILabel?

    let weatherViewModel = WeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    @IBAction func requestDataTapped(_ sender: UIButton) {
        weatherViewModel.getWeather()
    }

    private func setupBindings() {
        weatherViewModel.temperature.bind { value in
            self.currentTemperature?.text = String(value)
        }

        weatherViewModel.temperatureFeelsLike.bind { value in
            self.feelsLikeTemperature?.text = String(value)
        }
    }
}
