import UIKit
// Default initialization

do {
    class UserSession {
        var onlineStatus: Bool = true
    }

    let session = UserSession()
}

do {
    class UserSession {
        var onlineStatus: Bool = true
        
        init() {
            
        }
    }

    let session = UserSession()
}


do {
    class UserSession {
        var onlineStatus: Bool
        init() {
            self.onlineStatus = true
        }
    }

    let session = UserSession()
}

do {
    struct Coordinate {
        var x, y: Int
    }

    let coodinate = Coordinate(x: 4, y: 2)
}


do {
    struct Device {
        let model: String
        let color: UIColor
    }

    let phone = Device(model: "iPhone", color: .purple)
}

do {
    struct Device {
        let color: UIColor
        let model: String
    }

    let phone = Device(color: .purple, model: "iPhone")
}



do {
    class Vehicle {
        let color: UIColor
        
        init(color: UIColor) {
            self.color = color
        }
    }

    class Car: Vehicle {
        let sport: Bool
        
        init(sport: Bool) {
            self.sport = sport
            super.init(color: .gray)
        }
    }
    
    let car = Car(sport: true)
}

do {
    class Vehicle {
        let color: UIColor
        
        init(color: UIColor) {
            self.color = color
        }
    }

    class Car: Vehicle {
        let sport: Bool
        
        init(color: UIColor, sport: Bool) {
            self.sport = sport
            super.init(color: color)
        }
        
        override init(color: UIColor) {
            self.sport = false
            super.init(color: color)
        }
    }
    
    let car = Car(color: .purple , sport: true)
}


do {
    class Vehicle {
        let color: UIColor
        
        init(color: UIColor) {
            self.color = color
        }
        
        convenience init() {
            self.init(color: .gray)
        }
    }

    class Car: Vehicle {
        let sport: Bool
        
        init(color: UIColor, sport: Bool) {
            self.sport = sport
            super.init(color: color)
        }
        
        convenience init() {
            self.init(color: .gray, sport: false)
        }
    }
    
    let car = Car(color: .purple , sport: true)
}
