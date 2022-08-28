//
//  PlaceCollectionViewCell.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "PlaceCollectionViewCell"
    
    lazy var posterImage: UIImageView! = {
        let image = UIImageView(image: UIImage(systemName: "person.fill"))
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel! = {
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
        contentView.addSubview(posterImage)
        contentView.addSubview(titleLabel)
        
        posterImage.frame = CGRect(x: 5, y: 0, width: contentView.frame.size.width - 10, height: contentView.frame.size.height - 50)
        titleLabel.frame = CGRect(x: 5, y: contentView.frame.size.height - 50, width: contentView.frame.size.width - 10, height: 50)
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
