//
//  PlacesManager.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 29.08.2022.
//

import Foundation

protocol PlacesManagerProtocol {
    var output: PlacesManagerOutput? { get set }
    var networkManager: NetworkManagerProtocol! { get }
    func load<T:Codable>(ofType: T.Type, requestURL: String, requestAction: String)
    
}

protocol PlacesManagerOutput: AnyObject {
    func success<T>(result: T)
    func failure(error: Error)
}

final class PlacesManager: PlacesManagerProtocol {
    static let shared: PlacesManagerProtocol = PlacesManager(networkManager: NetworkManager())
    
    weak var output: PlacesManagerOutput?
    let networkManager: NetworkManagerProtocol!
    
    
    private init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    
    func load<T:Codable>(ofType: T.Type,requestURL: String ,requestAction: String) {
        self.networkManager.get(ofType: T.self, requestURL: requestURL, requestAction: requestAction){[weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let items):
                    self.output?.success(result: items)

            case .failure(let error):
                self.output?.failure(error: error)
            }
        }
    }
}
