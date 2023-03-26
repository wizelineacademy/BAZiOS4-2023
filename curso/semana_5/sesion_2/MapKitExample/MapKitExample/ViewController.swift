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
    let museum = CLLocationCoordinate2D(latitude: 37.83721054181996, longitude: -122.47647566284309)
//    let depa = CLLocationCoordinate2D(latitude: 25.648099221806497, longitude: -100.29917553062695)
    let wizeline = CLLocationCoordinate2D(latitude: 19.427498371104658, longitude: -99.1652054119615)
    
    private var myAnnotations: [MKAnnotation]?
    
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.preferredConfiguration = ViewController.getStandardConfiguration()
        map.showsCompass = true
        map.showsScale = true
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        registerCustomAnnotations()
        configLocation()
        addAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Center on coordinate
//        mapView.setCenter(goldenGateBridge, animated: true)
        
        // Center on region
        let region = MKCoordinateRegion(center: wizeline, latitudinalMeters: 1500, longitudinalMeters: 3000)
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
    
    // MARK: - MapKit annotations
    func addAnnotations(){
        /// Anotacion simple
        let annotation = MKPointAnnotation()
        annotation.coordinate = wizeline
        mapView.addAnnotation(annotation)
        /// Anotacion customizada
        let custom = CustomAnnotation(coordinate: wizeline)
        myAnnotations = [custom]
        mapView.addAnnotation(custom)
    }
    
    func registerCustomAnnotations(){
        mapView.delegate = self
//        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self))
        mapView.register(WizelineAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self))
        mapView.register(WizelineAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CustomAnnotation.self))
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
            mapView.showsUserLocation = true
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            /// Evitar customizar la anotacion del usuario
            return nil
        }
        if annotation.isKind(of: CustomAnnotation.self){
            let identifier:String = NSStringFromClass(CustomAnnotation.self)
            
            
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation) as? WizelineAnnotationView{
                
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure, primaryAction: UIAction(title: "Botón derecho", handler: { _ in
                    print("Dio click en el boton derecho")
                }))
                
                return annotationView
            }
            
            
            
            
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /// Se recomienta ocultar las vistas customizables a partir de 10,000 width
        let zoomWidth = mapView.visibleMapRect.size.width
        print(zoomWidth)
    }
    
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
