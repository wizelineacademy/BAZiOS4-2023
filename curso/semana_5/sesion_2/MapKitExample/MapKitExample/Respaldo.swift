//
//  Respaldo.swift
//  MapKitExample
//
//  Created by Benny Reyes on 26/03/23.
//

import Foundation
//
////  CustomAnnotationView.swift
////  MapKitExample
////
////  Created by Benny Reyes on 23/03/23.
////
//
//import MapKit
//
//class CustomAnnotationView: MKAnnotationView {
//    
////    override var intrinsicContentSize: CGSize{
////        return CGSize(width: 100, height: 100)
////    }
//    
//    private lazy var labelView: UILabel = {
//        let label = UILabel(frame: .zero)
//        label.font = UIFont.preferredFont(forTextStyle: .caption1) // Se recomienda utilizar este font para el tamaño
//        label.numberOfLines = 0
//        label.backgroundColor = .red
//        label.text = "SIN TITULO"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.preferredMaxLayoutWidth = 100
//        return label
//    }()
//    
//    private lazy var imageView: UIImageView = {
//        let imgView = UIImageView(frame: .zero)
//        imgView.image = UIImage(named: "wizeline")
//        return imgView
//    }()
//    
//    private lazy var stackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews:  [imageView, labelView])
//        stack.backgroundColor = .green
//        stack.layer.cornerRadius = 10
//        stack.axis = .vertical
//        stack.alignment = .top
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.spacing = 10
//        return stack
//    }()
//    
//    let v = UIView(frame: .zero)
//    
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        setUpView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setUpView(){
//        
//        addSubview(v)
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = .red
//        v.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
//        v.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
////        v.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
////        v.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
//        v.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        v.heightAnchor.constraint(equalToConstant: 100).isActive = true
////        addSubview(stackView)
////        // Anchor the top and leading edge of the stack view to let it grow to the content size.
////        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
////        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//    }
//    
//    override func prepareForDisplay() {
//        super.prepareForDisplay()
//        if let custom = annotation as? CustomAnnotation{
//            labelView.text = custom.title
//            imageView.image = UIImage(named: "wizeline")
//        }
//        setNeedsLayout()
//    }
//    
//}
