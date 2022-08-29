//
//  MapPresenter.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 28.08.2022.
//

import Foundation
import MapKit

protocol MapPresenterProtocol: AnyObject {
    var output: MapPresetnerOutput? { get set }
    var menu: [Menu] { get set }
    var annotations: [Annotation] { get set }
    func setUpData()
}

protocol MapPresetnerOutput: AnyObject {
    func success()
    func failure()
}

final class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewControllerProtocol!
    weak var output: MapPresetnerOutput?
    
    var menu: [Menu] = []
    var places: [Place] = []
    var latitides: [Double] = []
    var longitudes: [Double] = []
    var coordinates: [CLLocationCoordinate2D] = []
    var annotations: [Annotation] = []
    
    private var placesManager: PlacesManagerProtocol = PlacesManager.shared
    
    func setUpData() {
        let data = Data.shared
        self.places =  data.places
        convertCoordinates(places: places)
        createCoordinates()
        createAnnotation()
        getMenu(requestAction: "getMenu")
        print("а где \(menu)")
    }
    
    init(view: MapViewControllerProtocol) {
        self.view = view
    }
    
}

extension MapPresenter {
    func getMenu(requestAction: String) {
        placesManager.load(ofType: [Menu].self, requestURL: "http://94.127.67.113:8099/", requestAction: requestAction)
        placesManager.output = self
    }
    
    private func convertCoordinates(places: [Place]) {
        places.forEach { place in
            latitides.append( place.latitide ?? 0)
            longitudes.append(place.longitude ?? 0)
        }
        print("latit \(latitides)")
    }
    private func createCoordinates() {
        let count = latitides.count - 1
        for iter in 0...count {
            let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitides[iter]),
                                               longitude: CLLocationDegrees(longitudes[iter]))
            print("coord\(coord)")
            coordinates.append(coord)
        }
    }
    
    private func createAnnotation() {
        var itter = 0
        coordinates.forEach { coord in
            let annotation = Annotation(title: places[itter].name ?? "Название", coordinate: coord)
            annotations.append(annotation)
            itter += 1
        }
    }
}

extension MapPresenter: PlacesManagerOutput {
    func success<T>(result: T) {
        if let result = result as? [Menu] {
            self.menu = result
            self.output?.success()
            print("получили меню \(result)")
        } else {return}
    }
    
    func failure(error: Error) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.output?.failure()
        }
    }
}
