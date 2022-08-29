//
//  Data.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import Foundation

class Data {
    static let shared = Data()
    var places: [Place] = []

    private init() { }
}
