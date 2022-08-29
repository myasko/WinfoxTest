//
//  MenuViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var menu: [Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1)
        self.tabBarController?.tabBar.isHidden = true
        setUpCollectionView()
        print(menu)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(menu: [Menu]) {
        super.init(nibName: nil, bundle: nil)
        self.menu = menu
    }
    
    
    
    func setUpCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: ((view.frame.size.width) - 10),
                                 height: (view.frame.size.width/4))
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }

        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.indentifier)

        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.indentifier, for: indexPath) as! MenuCollectionViewCell
        let dish = self.menu[indexPath.row]
        cell.configure(image: dish.image!, price: dish.price, name: dish.name, weight: dish.weight, desc: dish.desc)
        cell.poster.image = UIImage(named: dish.image!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        menu.count
    }
}
