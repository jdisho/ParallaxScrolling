//
//  ViewController.swift
//  ParallaxScrolling
//
//  Created by Joan Disho on 09.06.18.
//  Copyright © 2018 Joan Disho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var photos = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photos"
        
        configureCollectionView()
        configurePhotos()
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: ParallaxFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.dataSource = self

        view.addSubview(collectionView)

        guard let layout = collectionView.collectionViewLayout as? ParallaxFlowLayout else { return }
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        let width = view.frame.width - (layout.sectionInset.left + layout.sectionInset.right)
        layout.itemSize = CGSize(width: width, height: 150)
    }

    private func configurePhotos() {
        guard let path = Bundle.main.path(forResource: "Photos", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let photos = dict["photos"] as? [AnyObject] else { return }

        self.photos = photos
    }

}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as?  PhotoCell else { return UICollectionViewCell() }
        let photo = photos[indexPath.item]
        if let filename = photo["filename"],
            let value = filename,
            let string = value as? String {
            let layout = collectionView.collectionViewLayout as? ParallaxFlowLayout
            cell.imageView.image = UIImage(named: string)
            cell.maxParallaxOffset = layout?.maxParallaxOffset
        }

        return cell
    }
}

