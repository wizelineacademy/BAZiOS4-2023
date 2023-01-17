class Goodbye {
    deinit {
        print("Goodbye - \(type(of: self))")
    }
}

// Reference cycle
do {
    class Person: Goodbye {
        var apartment: Apartment?
    }

    class Apartment: Goodbye {
        var tenant: Person?
        func rent(to person: Person) {
            self.tenant = person
            person.apartment = self
        }
    }

    let john = Person()
    let loft = Apartment()

    loft.rent(to: john)
    print("Departamento rentado")
}

// weak reference
do {
    class Person: Goodbye {
        var apartment: Apartment?
    }

    class Apartment: Goodbye {
        weak var tenant: Person?
        func rent(to person: Person) {
            self.tenant = person
            person.apartment = self
        }
    }

    let john = Person()
    let loft = Apartment()

    loft.rent(to: john)
    print("Departamento rentado")
}

// unowned reference
do {
    class Person: Goodbye {
        var apartment: Apartment?
    }

    class Apartment: Goodbye {
        unowned var tenant: Person
        init(tenant: Person) {
            self.tenant = tenant
            super.init()
            tenant.apartment = self
        }
    }

    let john = Person()
    let loft = Apartment(tenant: john)

    print("Departamento rentado")
}

// Reference cycle on closure
do {
    class Person: Goodbye {
        var apartment: Apartment?
    }
    
    class Apartment: Goodbye {
        weak var tenant: Person?
        var rent: ((Apartment) -> Void)? {
            didSet {
                rent?(self)
            }
        }
    }
    
    let john = Person()
    let loft = Apartment()
    
    loft.rent = { [person = john] apartment in
        apartment.tenant = person
        person.apartment = apartment
    }
    print("Departamento rentado")
}

// weak reference on closure
do {
    class Person: Goodbye {
        var apartment: Apartment?
    }
    
    class Apartment: Goodbye {
        weak var tenant: Person?
        var rent: ((Apartment) -> Void)? {
            didSet {
                rent?(self)
            }
        }
    }
    
    let john = Person()
    let loft = Apartment()
    
    loft.rent = { [weak person = john] apartment in
        apartment.tenant = person
        person?.apartment = apartment
    }
    print("Departamento rentado")
}

// unowned reference on closure
do {
    class Person: Goodbye {
        var apartment: Apartment?
    }
    
    class Apartment: Goodbye {
        weak var tenant: Person?
        var rent: ((Apartment) -> Void)? {
            didSet {
                rent?(self)
            }
        }
    }
    
    let john = Person()
    let loft = Apartment()
    
    loft.rent = { [unowned person = john] apartment in
        apartment.tenant = person
        person.apartment = apartment
    }
    print("Departamento rentado")
}
