//
//  ViewController.swift
//  MapKitExample
//
//  Created by Benny Reyes on 08/03/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let manager = CLLocationManager()
    let goldenGateBridge = CLLocationCoordinate2D(latitude: 37.82055575885935, longitude: -122.4779117772426)
    
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.preferredConfiguration = ViewController.getImageConfiguration()
        map.showsCompass = true
        map.showsScale = true
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpView()
        configLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        mapView.setCenter(goldenGateBridge, animated: true)
        let region = MKCoordinateRegion(center: goldenGateBridge, latitudinalMeters: 750, longitudinalMeters: 1500)
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: Config Methods
    func setUpView(){
        guard let view = view else { return }
        view.addSubview(mapView)
        view.addConstraints([
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: mapView, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: mapView, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: mapView, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: mapView, attribute: .left, multiplier: 1.0, constant: 0)
        ])
    }
    
    // MARK: - MapKitConfiguration
    fileprivate static func getImageConfiguration() -> MKMapConfiguration {
        let config = MKImageryMapConfiguration()
        config.elevationStyle = .flat // Valor por default 'flat'
        return config
    }
    
    fileprivate static func getHybridConfiguration() -> MKMapConfiguration {
        let config = MKHybridMapConfiguration()
        config.elevationStyle = .flat
        config.showsTraffic = true
        config.pointOfInterestFilter = .includingAll
        return config
    }
    
    fileprivate static func getStandardConfiguration() -> MKMapConfiguration {
        let config = MKStandardMapConfiguration()
        config.elevationStyle = .flat // Valor por default 'flat'
        config.emphasisStyle = .default
        config.showsTraffic = false // Valor por default 'false'
        config.pointOfInterestFilter = .includingAll
        return config
    }
    

    // MARK: - CoreLocation
    
    /// Configurar el coreLocation para solicitar permiso de locacion
    func configLocation(){
        manager.delegate = self
        validatePermision()
    }
    
    /// Muestra los  distintos status de autorizacion para el acceso a la localizacion del usuario
    func validatePermision(){
        switch manager.authorizationStatus{
        case .authorized:
            print("Hasta iOS 8.0")
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            print("En cualquier momento")
            manager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:
            print("Mientras esta en uso")
            manager.startUpdatingLocation()
            break
        case .denied:
            print("El usuario nego, o deshabilito los servicios globalmente")
            break
        case .restricted:
            print("La app no esta autorizada")
            requestLocationPermisionWhenIsDenied()
            break
        case .notDetermined:
            print("Aun no se solicita permiso")
            manager.requestAlwaysAuthorization()
            break
        @unknown default:
            print("Futuras actualizaciones")
            break
        }
    }
    
    /// Este metodo solicita envia al usuario a cambiar los permisos de esta aplicacion
    func showSettingsPermision(){
        guard let url = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    /// Mostrar al usuario un mensaje para informarle que denego el permiso
    func requestLocationPermisionWhenIsDenied(){
        let alert = UIAlertController(title: "Permiso denegado", message: "Favor de dar permisos de ubicacion desde la configuración", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ir a configuración", style: .default, handler: { [weak self] _ in
            self?.showSettingsPermision()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: { _ in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
    

}

// MARK: - MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
    
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate{
    
    // MARK: PERMISOS
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        validatePermision()
    }
    
    // MARK: MONITOREO
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else { return }
        print("Coordenadas: \(last.coordinate.latitude), \(last.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
