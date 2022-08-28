//
//  TabBarViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import UIKit
import SwiftUI

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        navigationItem.hidesBackButton = true
    }
    
    private func generateTabBar() {
        viewControllers = [
            UINavigationController(rootViewController: generateVC(viewController: PlacesViewController(),
                       title: "Рестораны",
                       image: UIImage(systemName: "fork.knife.circle.fill"))),
            UINavigationController(rootViewController: generateVC(viewController: MapViewController(),
                       title: "На карте",
                       image: UIImage(systemName: "map.circle.fill")))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }

}

extension UIColor {
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    }
    static var mainWhite: UIColor {
        #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
    }
    static var tabBarItemLight: UIColor {
        #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 0.5084592301)
    }
}
