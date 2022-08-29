//
//  MenuCollectionViewCell.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 29.08.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "MenuCollectionViewCell"
    
    var poster: NetworkImageView = {
        let imgV = NetworkImageView()
        imgV.clipsToBounds = true
        imgV.layer.masksToBounds = true
        imgV.layer.cornerRadius = 10
        imgV.contentMode = .scaleToFill
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Название блюда"
        label.font = label.font.withSize(15)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "цена"
        label.font = label.font.withSize(14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "вес"
        label.font = label.font.withSize(14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.text = "Вкусное блюдо Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
        label.font = label.font.withSize(10)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
        
    }
    
    public func configure( image: String, price: Double?, name: String?, weight: Double?,  desc: String?) {
        titleLabel.text = name
        poster.loadImage(url: URL(string: image)!)
        descLabel.text = desc
        priceLabel.text = String(price!)
        weightLabel.text = String(weight!)
        descLabel.text = desc
    }
    
    private func layout() {
        
        contentView.backgroundColor = UIColor(red: 0.56, green: 0.49, blue: 0.67, alpha: 0.5)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            poster.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            poster.widthAnchor.constraint(equalToConstant: 75),
            
            titleLabel.leftAnchor.constraint(equalTo: poster.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            weightLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -10),
            weightLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            descLabel.leftAnchor.constraint(equalTo: poster.rightAnchor, constant: 10),
            descLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor, constant: -10),
            descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
            
        ])
    }
}
