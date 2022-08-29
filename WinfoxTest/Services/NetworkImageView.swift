//
//  NetworkImageView.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 29.08.2022.
//

import UIKit

final class NetworkImageView: UIImageView {

    func loadImage(url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self!.image = UIImage(data: data)
                    }
                }
            }
        dataTask.resume()
    }
}
