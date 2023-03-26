//
//  WizelineAnnotationView.swift
//  MapKitExample
//
//  Created by Benny Reyes on 26/03/23.
//

import MapKit

class WizelineAnnotationView: MKAnnotationView{
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "wizeline")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var stackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.backgroundColor = .systemGray5
        stack.layer.cornerRadius = 5
//        stack.layer.borderWidth = 1
//        stack.layer.borderColor = UIColor.darkGray.cgColor
        stack.clipsToBounds = true
        return stack
    }()
    
    private lazy var container:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life Cycle
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        if let annotation = annotation as? CustomAnnotation {
            titleLabel.text = annotation.title
        }
    }
    
    // MARK: - Config View
    func setupView(){
        addSubview(container)
        container.addSubview(stackView)
        
        /// Centrar la vista sobre la coordenada
        container.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        /// Asignar el tamaño maximo
        container.widthAnchor.constraint(equalToConstant: 80).isActive = true
        container.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        /// Stack View
        stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 5).isActive = true
        stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 5).isActive = true
        stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5).isActive = true
        stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 5).isActive = true
    }
    
}
