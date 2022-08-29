//
//  PlaceCollectionViewCell.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "PlaceCollectionViewCell"
    
    var poster: NetworkImageView! = {
        let image = NetworkImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel! = {
        let label = UILabel()
        label.text = "Название"
        label.numberOfLines = 0
        label.font = label.font.withSize(10)
        label.textAlignment = .center
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
    
    private func layout() {
        contentView.addSubview(poster)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor(red: 0.56, green: 0.49, blue: 0.67, alpha: 0.5)
        contentView.layer.cornerRadius = 10
        let height = contentView.frame.height
        let width = contentView.frame.width
        
        poster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        poster.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        poster.heightAnchor.constraint(equalToConstant: height - 25).isActive = true
        poster.widthAnchor.constraint(equalToConstant: width - 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 1).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    public func configure(title: String, image: String) {
        titleLabel.text = title
        poster.loadImage(url: URL(string: image)!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}

