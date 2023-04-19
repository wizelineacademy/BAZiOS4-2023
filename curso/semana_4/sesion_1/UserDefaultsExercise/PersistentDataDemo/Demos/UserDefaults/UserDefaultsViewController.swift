//
//  UserDefaultsViewController.swift
//  PersistentDataDemo
//
//  Created by Jorge Benavides on 24/03/23.
//

import UIKit

class UserDefaultsViewController: FormViewController {
    
    var user: User?

    // TODO: 2. Create an initialize that receives an object for storage operations
    // let storageObject: StorageProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "User Defaults"
        view.backgroundColor = .white
    }

    // TODO: 3.1 Use the instance `storageObject` of the storage protocol to do 'write' operations
    override func writeData() {
        user = writeFormView.getData

        UserDefaults.standard.set(user?.name, forKey: "kUserName")
        UserDefaults.standard.set(user?.age, forKey: "kUserAge")
        UserDefaults.standard.set(user?.balance, forKey: "kUserBalance")

        // Can't store non-property list object
//        UserDefaults.standard.set(user, forKey: "kUserModel")
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: "kUserModel")
        } catch {
            print("Can not store:", error)
        }
    }

    // TODO: 3.2 Use the instance `storageObject` of the storage protocol to do 'read' operations
    override func readData() {
        user?.name = UserDefaults.standard.string(forKey: "kUserName")
        user?.age = UserDefaults.standard.integer(forKey: "kUserAge")
        user?.balance = UserDefaults.standard.double(forKey: "kUserBalance")

        //Can't retrieve non-property list object
//        user = UserDefaults.standard.object(forKey: "kUserModel") as? User
        do {
            guard let data = UserDefaults.standard.object(forKey: "kUserModel") as? Data else {
                throw NSError(domain: Bundle.main.bundlePath, code: -1)
            }
            self.user = try JSONDecoder().decode(User.self, from: data)
        } catch {
            print("Can not store:", error)
        }

        readFormView.setData(user)
    }
}
