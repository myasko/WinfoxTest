//
//  Place.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import Foundation
import MapKit

struct Place: Codable {
    let image: String?
    let name: String?
    let latitide: Double?
    let desc: String?
    let longitude: Double?
}

struct Menu: Codable {
    let image: String?
    let price: Double?
    let name: String?
    let weight: Double?
    let desc: String?
}

class Annotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

struct Places {
    let places: [Place]
}


