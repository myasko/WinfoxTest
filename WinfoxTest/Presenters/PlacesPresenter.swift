//
//  PlacesPresenter.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import Foundation

protocol PlacesPresenterProtocol: AnyObject {
    var output: PlacesPresetnerOutput? { get set }
    var places: [Place] { get set }
    func setUpData()
}

protocol PlacesPresetnerOutput: AnyObject {
    func success()
    func failure()
}

final class PlacesPresenter: PlacesPresenterProtocol {
    
    weak var view: PlacesViewControllerProtocol!
    weak var output: PlacesPresetnerOutput?
    var places: [Place] = []
    
    private var placesManager: PlacesManagerProtocol = PlacesManager.shared
    
    func setUpData() {
        getPlaces(requestAction: "getPlaces")
        print(places.count)
    }
    
    init(view: PlacesViewControllerProtocol) {
        self.view = view
    }
    
    
}

extension PlacesPresenter {
    func getPlaces(requestAction: String) {
        placesManager.load(ofType: [Place].self, requestURL: "http://94.127.67.113:8099/", requestAction: requestAction)
        placesManager.output = self
    }
}

extension PlacesPresenter: PlacesManagerOutput {
    func success<T>(result: T) {
        if let result = result as? [Place] {
            self.places = result
            let data = Data.shared
            data.places = result
            self.output?.success()
        } else {return}
    }
    
    func failure(error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.output?.failure()
        }
    }
}
