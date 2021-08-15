import UIKit

class WeatherViewController: UIViewController {

     //MARK: IBOutlets
    @IBOutlet weak var requestBtn: UIButton?
    @IBOutlet weak var currentTemperature: UILabel?
    @IBOutlet weak var feelsLikeTemperature: UILabel?
    @IBOutlet weak var myCollectionView: UICollectionView?

    //MARK: Vars/Lets
    let weatherViewModel = WeatherViewModel()

    //MARK: Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        registerNibs()
        setupCollectionView()
    }

    //MARK: IBActions
    @IBAction func requestDataTapped(_ sender: UIButton) {
        //weatherViewModel.getWeather()
    }

    //MARK: Flow functions
    private func registerNibs() {
        let nib1 = UINib(nibName: CollectionViewCellWeatherTopHeader.typeName, bundle: nil)
        myCollectionView?.register(nib1, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewCellWeatherTopHeader.typeName)

        let nib2 = UINib(nibName: CollectionViewCellWeatherMiddleHeader.typeName, bundle: nil)
        myCollectionView?.register(nib2, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewCellWeatherMiddleHeader.typeName)

        let nib3 = UINib(nibName: CollectionViewCellTest.typeName, bundle: nil)
        myCollectionView?.register(nib3, forCellWithReuseIdentifier: CollectionViewCellTest.typeName)
    }

    private func setupCollectionView() {
        myCollectionView?.collectionViewLayout = WeatherCollectionViewLayout()
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
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

//MARK: Extensions
//MARK: - UIScrollViewDelegate
extension WeatherViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let headerHeightMaxChange: CGFloat = Constants.WeatherHeaders.topHeader.defaultHeight - Constants.WeatherHeaders.topHeader.minimumHeight
        var subOffset: CGFloat = 0

        if offsetY > headerHeightMaxChange {
            subOffset = offsetY - headerHeightMaxChange
        } else {
            subOffset = 0
        }

        NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationNames.setOffset), object: subOffset)
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 1 ? 1 : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTest.typeName, for: indexPath)

        cell.contentView.backgroundColor = .green
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if (kind == UICollectionView.elementKindSectionHeader) {
            switch indexPath.section {
            case 0:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: CollectionViewCellWeatherTopHeader.typeName,
                                                                       for: indexPath) as! CollectionViewCellWeatherTopHeader
            case 1:
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewCellWeatherMiddleHeader.typeName,
                                                                       for: indexPath) as! CollectionViewCellWeatherMiddleHeader
            default:
                print("No such header")
            }
        }

        return UICollectionReusableView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        var height: CGFloat = 0

        switch section {
        case 0:
            height = Constants.WeatherHeaders.topHeader.defaultHeight
        case 1:
            height = Constants.WeatherHeaders.middleHeader.defaultHeight
        default:
            height = 0 //no such header
        }
        return CGSize(width: view.frame.size.width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let topOffset: CGFloat = 44
        let bottomOffset: CGFloat = 40
        var height = view.frame.size.height - Constants.WeatherHeaders.topHeader.minimumHeight - Constants.WeatherHeaders.middleHeader.minimumHeight - topOffset - bottomOffset

        height += 350 // это чит, нужно как-то правильно посчитать размер для нижней ячейки
        return CGSize(width: view.frame.size.width, height: height)
    }
}
