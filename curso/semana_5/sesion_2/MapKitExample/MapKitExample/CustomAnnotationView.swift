//
//  CustomAnnotationView.swift
//  MapKitExample
//
//  Created by Benny Reyes on 23/03/23.
//

import MapKit

class CustomAnnotationView: MKAnnotationView {
    
    private lazy var backgroundCard:UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(backgroundCard)
        
        // Centrar la vista sobre el punto
        backgroundCard.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        // Darle tamaño a la vista
        backgroundCard.widthAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundCard.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}


