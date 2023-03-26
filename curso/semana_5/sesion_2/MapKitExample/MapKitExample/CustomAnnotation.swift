//
//  CustomAnnotation.swift
//  MapKitExample
//
//  Created by Benny Reyes on 23/03/23.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    // Opcional
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = "Wizeline"
        self.subtitle = "Mi subtitulo"
    }
}


