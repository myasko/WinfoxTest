//
//  PlacesViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import UIKit

class PlacesViewController: UIViewController {
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationController?.navigationBar.isHidden = true
        setUpCollectionView()
        setUpUI()
    }
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 4) - 4,
                                 height: (view.frame.size.width / 4) - 4)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }

        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCollectionViewCell.indentifier)
        
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    func setUpUI() {
        
    }
}

extension PlacesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCollectionViewCell.indentifier, for: indexPath) as! PlaceCollectionViewCell
        cell.configure(title: "Название \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Заведение \(indexPath.row)")
    }
    
}
