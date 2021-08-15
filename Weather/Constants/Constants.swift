import Foundation
import UIKit

class Constants {
    struct GlobalConstant {
        static let screenHeight = UIScreen.main.bounds.height
        static let screenWidth = UIScreen.main.bounds.width
    //    static let margin: CGFloat = 16
    //
    //    struct Units {
    //        static let windSpeed = "km/hr"
    //        static let precipitation = "cm"
    //        static let pressure = "hPa"
    //        static let visibility = "km"
    //    }
    }

    enum WeatherHeaders: Int {
        case topHeader, middleHeader

        var section: Int {
            return self.rawValue
        }

        var defaultHeight: CGFloat {
            switch self {
            case .topHeader:
                return 0.48 * GlobalConstant.screenHeight
            case .middleHeader:
                return 0.17 * GlobalConstant.screenHeight
            }
        }

        var minimumHeight: CGFloat {
            switch self {
            case .topHeader:
                return 100
            case .middleHeader:
                return defaultHeight
            }
        }
    }
}


