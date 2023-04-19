//
//  ViewClasses.swift
//  PersistentDataDemo
//
//  Created by Jorge Benavides on 22/03/23.
//

import UIKit

class View: UIView {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class StackView: UIStackView {

    init(_ views: [UIView]) {
        super.init(frame: .zero)
        views.forEach { addArrangedSubview($0) }
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class FormViewController: UIViewController {

    let writeFormView = UserFormView(buttonAction: "Guardar")
    let readFormView = UserFormView(buttonAction: "Cargar")

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let margin: CGFloat = 20

        writeFormView
            .layout
            .insert(in: view)
            .anchor(horizontal: view.layout.leftRightSafe, margin: margin)
            .anchor(vertical: (view.layout.topSafe, view.layout.centerY), margin: margin)
        writeFormView.onAction = { [weak self] in
            self?.writeData()
        }

        readFormView
            .layout
            .insert(in: view)
            .anchor(horizontal: view.layout.leftRightSafe, margin: margin)
            .anchor(vertical: (view.layout.centerY, view.layout.bottomSafe), margin: margin)
        readFormView.onAction = { [weak self] in
            self?.readData()
        }
    }

    func writeData() {}

    func readData() {}
}
