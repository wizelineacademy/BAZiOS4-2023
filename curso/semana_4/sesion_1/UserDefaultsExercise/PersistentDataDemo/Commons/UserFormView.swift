//
//  UserFormView.swift
//  PersistentDataDemo
//
//  Created by Jorge Benavides on 22/03/23.
//

import Foundation
import UIKit
import BuildableObjects

class UserFormView: StackView {
    // labels
    let nameLabel: UILabel
    let ageLabel: UILabel
    let balanceLabel: UILabel
    // input fields
    let nameInput: UITextField
    let ageInput: UITextField
    let balanceInput: UITextField
    // action buttons
    let actionButton: UIButton
    var onAction: (() -> Void)? = nil
    init(buttonAction: String) {
        nameLabel = .setup {
            $0.text = "Nombre"
        }
        ageLabel = .setup {
            $0.text = "Edad"
        }
        balanceLabel = .setup {
            $0.text = "Balance"
        }
        nameInput = .setup {
            $0.borderStyle = .roundedRect
            $0.autocorrectionType = .no
        }
        ageInput = .setup {
            $0.borderStyle = .roundedRect
            $0.keyboardType = .numberPad
        }
        balanceInput = .setup {
            $0.borderStyle = .roundedRect
            $0.keyboardType = .numbersAndPunctuation
        }
        actionButton = .setup {
            $0.setTitle(buttonAction, for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
        }

        super.init([
            nameLabel,
            nameInput,
            ageLabel,
            ageInput,
            balanceLabel,
            balanceInput,
            actionButton
        ])
        axis = .vertical
        distribution = .fillEqually
        actionButton.addTarget(self, action: #selector(actionButtonTriggered), for: .touchUpInside)
    }

    var getData: User {
        User(name: nameInput.text ?? "",
             age: ageInput.stringValue.integerValue,
             balance: balanceInput.stringValue.doubleValue)
    }

    func setData(_ user: User?) {
        nameInput.text = user?.name
        ageInput.text = String(user?.age ?? 0)
        balanceInput.text = String(user?.balance ?? 0)
    }

    @objc private func actionButtonTriggered() {
        onAction?()
        actionButton.alpha = 0
        UIView.animate(withDuration: 0.25, animations: { [weak actionButton] in
            actionButton?.alpha = 1
        })
    }
}

private extension UITextField {
    var stringValue: NSString {
        NSString(string: text ?? "")
    }
}
