//
//  PlacesViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import UIKit

protocol PlacesViewControllerProtocol: AnyObject {
    var presenter: PlacesPresenterProtocol! { get set }
}

class PlacesViewController: UIViewController, PlacesViewControllerProtocol {
    var presenter: PlacesPresenterProtocol!
    
    
    var collectionView: UICollectionView!
    var places: [Place] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 0.7)
        presenter = PlacesPresenter(view: self)
        navigationController?.navigationBar.isHidden = true
        setUpCollectionView()
        setUpUI()
        self.presenter.setUpData()
        presenter.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width / 4) - 4,
                                 height: (view.frame.size.width / 4) + 5)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }

        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
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
        let place = presenter.places[indexPath.row]
        places = presenter.places
        cell.configure(title: place.name ?? "Заведение", image: place.image!) //place.image!
        print(place.image!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Заведение \(indexPath.row)")
    }
    
}

extension PlacesViewController: PlacesPresetnerOutput {
    func success() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        print("succ")
    }
    
    func failure() {
        print("err")
    }
}
