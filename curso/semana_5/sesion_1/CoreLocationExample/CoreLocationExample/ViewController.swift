//
//  ViewController.swift
//  CoreLocationExample
//
//  Created by Benny Reyes on 04/03/23.
//

import UIKit
import CoreLocation

/// Este proyecto es un ejemplo de como utilizar CoreLocation
/// la vista principal solo muestra un label mostrando las coordenadas de usuario
/// Ademas el info.plist contiene las llaves que CoreLocation utiliza
/// Para cambiar a monitoreo, en el metodo didload descomenta la llamada al metodo configMonitoringVisits
class ViewController: UIViewController {
    @IBOutlet weak var lblText: UILabel!
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        configLocation()
        // configMonitoringVisits()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if [.authorized, .authorizedAlways, .authorizedWhenInUse].contains(manager.authorizationStatus){
            validateFullAccuracy()
        }
    }
    
    func configLocation(){
        manager.delegate = self
        validatePermision()
    }
    
    func configMonitoringVisits(){
        manager.startMonitoringVisits()
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
    
    func validateFullAccuracy(){
        switch manager.accuracyAuthorization{
        case .fullAccuracy:
            print("Full accuracy active")
            break
        case .reducedAccuracy:
            manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "PrimerEjemplo") { error in
                print(error?.localizedDescription ?? "")
            }
            break
        @unknown default:
            print("No determinado")
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

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    // MARK: PERMISOS
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        validatePermision()
    }
    
    // MARK: MONITOREO
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else { return }
        print("Coordenadas: \(last.coordinate.latitude), \(last.coordinate.longitude)")
        lblText.text = "\(last.coordinate.longitude) - \(last.coordinate.latitude)"
        print(last.description)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print("Se pauso o detuvo el monitoreo")
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        print("Se reanundo el monitoreo")
    }
    
    // MARK: VISITAS
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        lblText.text = visit.description
        if visit.departureDate == Date.distantFuture{
            print("El usuario llego a la locación: \(visit.description) (\(visit.coordinate.latitude), \(visit.coordinate.longitude)")
            print("A la hora: \(visit.arrivalDate)")
        }else{
            print("El usuario salio de la locación: \(visit.description) (\(visit.coordinate.latitude), \(visit.coordinate.longitude)")
            print("A la hora: \(visit.departureDate)")
        }
    }
    
}
