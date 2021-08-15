//
//  CollectionViewCellTest.swift
//  Weather
//
//  Created by Roman Kosinevskyi on 08.08.2021.
//

import UIKit

struct NotificationNames {
    static let setOffset = "setOffset"
}

class CollectionViewCellTest: UICollectionViewCell {

    @IBOutlet weak var myCollection: UICollectionView?

    override func awakeFromNib() {
        super.awakeFromNib()
        myCollection?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        myCollection?.dataSource = self
        myCollection?.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(handleSetOffset), name: Notification.Name(rawValue: NotificationNames.setOffset), object: nil)
    }

    @objc func handleSetOffset(notification: Notification) {
        if let offset = notification.object as? CGFloat {
            myCollection?.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
}

extension CollectionViewCellTest: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myCollection?.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) else {
            return UICollectionViewCell()
        }

        cell.backgroundColor = .orange

        return cell
    }
}

extension CollectionViewCellTest: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: frame.width, height: 0)
    }
}
