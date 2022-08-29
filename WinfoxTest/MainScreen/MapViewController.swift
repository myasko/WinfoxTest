//
//  MapViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import UIKit
import MapKit


protocol MapViewControllerProtocol: AnyObject {
    var presenter: MapPresenterProtocol! { get set }
}

class MapViewController: UIViewController, MapViewControllerProtocol {
    
    var menu: [Menu] = []
    var mapView = MKMapView()
    
    let locationManager = CLLocationManager()
    
    var presenter: MapPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapPresenter(view: self)
        view.backgroundColor = .red
        mapView.delegate = self
        setUpUI()
        self.presenter.setUpData()
        presenter.output = self
        presenter.annotations.forEach { annotation in
            mapView.addAnnotation(annotation)
        }
        print("anno \(presenter.annotations)")
        print(menu)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkLocationEnabled()
    }
    
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkAuthorization()
        } else {
            showAlert(title:  "У вас выключена служба геолокации", message: "Хотите включить?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func checkAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            showAlert(title: " Использоввание геолокации запрещено.", message: "Хотите разрешить?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        @unknown default:
            return
        }
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func setUpUI() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func showAlert(title: String, message: String?, url: URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { alert in
            if let url = url {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) { // for IOS 13
        checkAuthorization()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { // for IOS 14*
        checkAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation  = annotation as? Annotation else { return nil }
        var viewMarker: MKMarkerAnnotationView
        let idView = "marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
            viewMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return viewMarker
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let menuVC = MenuViewController(menu: menu)
        self.navigationController?.pushViewController(menuVC, animated: true)
    }
}

extension MapViewController: MapPresetnerOutput {
    func success() {
        DispatchQueue.main.async {
            self.menu = self.presenter.menu
        }
        print("succ")
    }
    
    func failure() {
        print("err")
    }
}
