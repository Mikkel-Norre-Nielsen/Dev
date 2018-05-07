//Mikkel Norre Nielsen
//ihiehw8r89rew
import Foundation

enum State { case created, booked, startet, onHold, finished, arcive }
let states = ["created", "booked", "startet", "onHold", "finished", "arcive"] // der findes ikke en måde at "loope" igennem en enum derfor laver jeg et array

enum Types { case Customer, Car, Order }


/*************************************************************************************************************************************************************************************************************
 Classes og default data set i 'tabeller' (Arays)
 Valget for at bruge clases fremfor structs er at variabler peger hen på det oprendelige objekt
*************************************************************************************************************************************************************************************************************/

class Customer: CustomStringConvertible {
    let id: Int
    var name:String
    var address:String
    var email:String
    
    var description: String {
        return "Id: \(id)   Name: \(name)   Email: \(email)   Address: \(address)"
    }
    
    init(id: Int, name: String = "", address: String = "", email: String = "") {
        self.id = id
        self.name = name
        self.address = address
        self.email = email
    }
}

class Car: CustomStringConvertible {
    let id: Int
    var brand:String //Hvis det her var en reel aplication med database ville jeg have en tabel med de forskellige mærker
    var model:String
    var vinNumber:String
    var regNumber:String
    var productionYear:Int? //Det kan ske man ikke kender årstallet
    
    var description: String {
        return "Id: \(id)   Production year: \(productionYear == nil ? "" : String(productionYear ?? 0))    Type: \(regNumber) \(brand) \(model)    Vinnumber: \(vinNumber)"
    }
    
    init(id:Int, brand: String = "", model: String = "", vinNumber: String = "", regNumber: String = "", productionYear: Int? = nil) {
        self.id = id
        self.brand = brand
        self.model = model
        self.productionYear = productionYear
        self.regNumber = regNumber
        self.vinNumber = vinNumber
    }
}

class Order: CustomStringConvertible {
    let id: Int
    var car: Car?
    var customer:Customer
    var orderDescription:String
    var state:State
    
    var description: String {
        return "Id: \(id)   Customer name: \(customer.name)    State: \(state)    Description: \(orderDescription)"
    }
    
    init(id: Int, car: Car?, customer: Customer, description: String, state:State = .created) {
        self.id = id
        self.car = car
        self.customer = customer
        self.orderDescription = description
        self.state = state
    }
}

var customers:[Customer] = [
    Customer(id: 0, name: "Mads"),
    Customer(id: 1, name: "Jens", address: "Viggo alle 22", email: "Jensen@hotmail.com"),
    Customer(id: 2, name: "Viggo"),
    Customer(id: 3, name: "Kenneth", address: "Jarbæk.... 34", email: "Kenneth@mail.dk"),
    Customer(id: 4, name: "Hans"),
    Customer(id: 5, name: "Vibeke"),
    Customer(id: 6, name: "Jeanette"),
    Customer(id: 7, name: "Henriette"),
    Customer(id: 8, name: "Klaus")
]

var cars:[Car] = [
    Car(id: 0, brand: "Audi", model: "Q7", vinNumber: "F43TH67I6IR5U78H", regNumber: "XL45698", productionYear: 2007),
    Car(id: 1, brand: "Skoda", model: "Octavia", regNumber: "XL56789", productionYear: 2009),
    Car(id: 2, brand: "Volvo", model: "V90", regNumber: "XC989898", productionYear: 2018),
    Car(id: 3, brand: "BMW", model: "320D", regNumber: "BP987654", productionYear: 2017),
    Car(id: 4, brand: "VW", model: "Golf", vinNumber: "HGTRIUH86H86", regNumber: "BM98765", productionYear: 2008),
    Car(id: 5, brand: "VW", model: "Passat", regNumber: "FG234567", productionYear: 2012),
    Car(id: 6, brand: "Volvo", model: "XC90", regNumber: "KJ456789", productionYear: 2013),
    Car(id: 7, brand: "Alfa Romeo", model: "Guilia", regNumber: "HJ99876", productionYear: 2019),
    Car(id: 8, brand: "Renault", model: "Clio", regNumber: "JH348908", productionYear:2004 ),
    Car(id: 9, brand: "Toyota", model: "Corolla", regNumber: "OP62872", productionYear: 1994)
]

var orders:[Order] = [
    Order(id: 0, car: cars[1], customer: customers[0], description: "Slangerne skal skiftes"),
    Order(id: 1, car: cars[0], customer: customers[2], description: "Krangen skal skiftes", state: .booked),
    Order(id: 2, car: cars[2], customer: customers[2], description: "Reflekser mangler", state: .finished),
    Order(id: 3, car: cars[9], customer: customers[4], description: "Slangerne skal skiftes", state: .startet),
    Order(id: 4, car: cars[3], customer: customers[5], description: "Bremserne virker ikke"),
    Order(id: 5, car: cars[5], customer: customers[8], description: "Gearne på forskifteren skal justeres", state: .onHold),
    Order(id: 6, car: cars[7], customer: customers[6], description: "Slangerne skal skiftes", state: .booked),
    Order(id: 7, car: cars[6], customer: customers[1], description: "Slangerne skal skiftes", state: .booked),
    Order(id: 8, car: cars[4], customer: customers[7], description: "Nye dæk med mere mønster"),
    Order(id: 9, car: cars[8], customer: customers[3], description: "Ny cykelsadel", state: .onHold)
]





/*************************************************************************************************************************************************************************************************************
 Defination af alle funktioner
*************************************************************************************************************************************************************************************************************/

func getNewId(type:Types) -> Int { // hvis det var en rigtig database dataene lå i ville denne være overflødig
    switch type {
    case .Car:
        return cars.count
    case .Customer:
        return customers.count
    case .Order:
        return orders.count
    }
}

func selectOrderState() -> State? {
    for i in 0..<states.count {
        print("\(i+1). \(states[i])")
    }
    
    var state:State?
    var hasState = false
    while !hasState {
        hasState = true
        switch readLine() ?? "" {
        case "1":
            state = State.created
        case "2":
            state = State.booked
        case "3":
            state = State.startet
        case "4":
            state = State.onHold
        case "5":
            state = State.finished
        case "6":
            state = State.arcive
        default:
            print("Not a valid option!")
            hasState = false
        }
    }
    return state
}

func getOrdersByState() {
    print("Wat state do you want to filter by?")
    let state = selectOrderState()

    for order in orders {
        if order.state == state {
            print(order)
        }
    }
}

func selectOrder() -> Order? {
    if !(orders.count > 0) {
        print("There is no orders!")
        return nil
    }
    
    for order in orders {
        print(order)
    }
    print("Type the id of the order you want to select")
    print()
    while true {
        if let input = readLine() {
            if let id = Int(input) {
                let selecedOrder = orders.first { (order) -> Bool in order.id == id }
                if let o = selecedOrder {
                    return o
                } else {
                    print("Not a valid option please try again!")
                }
            }
        }
    }

}

func changeOrderState(order:Order? = nil) {
    if let o = (order ?? selectOrder()) {
        print("Wat state should the order have?")
        if let state = selectOrderState() {
            o.state = state
        }
    }
}

func customer(customer inputCustomer:Customer? = nil) -> Customer { // Vælge, oprette og rediger en kunde, 'inputCustomer' skal ikke være nil hvis det er en kunde der skal redigeres
    let isEdit = inputCustomer != nil
    var customer:Customer? = inputCustomer
    var hasCustomer = false
    let error = { () in
        print("Not a valid option!")
        hasCustomer = false
    }
    
    while !hasCustomer {
        hasCustomer = true
        if !isEdit {
            print("+ ---------------------------------------------- +")
            print("| Type '1' to create a new customer to the order |")
            if (customers.count > 0) { print("| Type '2' to select a customer                  |") } // Man skal ikke have denne mugelighed hvis 'Tabellen' af kunder er tom
            print("+ ---------------------------------------------- +")
            print()
        }
    
    switch !isEdit ? (readLine() ?? "") : "1" {
        case "1":
            if !isEdit {
               customer = Customer(id: getNewId(type: .Customer))
                if let unwrapedCustomer = customer {
                    customers.append(unwrapedCustomer)
                }
            } else {
                print("Leave the input blank to keep the origional value")
            }
            
            var temp:String
            
            print("Customer name: " + (isEdit ? ("(" + (customer?.name ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                customer?.name = temp
            }
            
            print("Customer email: " + (isEdit ? ("(" + (customer?.email ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                customer?.email = temp
            }
            
            print("Customer address: " + (isEdit ? ("(" + (customer?.address ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                customer?.address = temp
            }
        case "2":
            if customers.count > 0 {
                for customer in customers {
                    print(customer)
                }
                print("Type the id of the customer you want to select")
                print()
                while true {
                    if let input = readLine() {
                        if let id = Int(input) {
                            let selecedCustomer = customers.first { (customer) -> Bool in customer.id == id }
                            if let c = selecedCustomer {
                                customer = c
                                break
                            } else {
                                print("Not a valid option please try again!")
                            }
                        }
                    }
                }
            } else {
                error()
            }
        default:
            error()
        }
    }
    
    return customer! // programmet kan ikke komme herned før der er valgt/oprettet en kunde....
}


func car(car inputCar:Car? = nil) -> Car? { // Vælge, oprette og rediger en bil, 'inputCar' skal ikke være nil hvis det er en bil der skal redigeres
    let isEdit = inputCar != nil
    var car:Car? = inputCar
    var hasCar = false
    
    while !hasCar {
        hasCar = true
        if !isEdit {
            print("+ ----------------------------------------- +")
            print("| Type '1' to create a new car to the order |")
            if cars.count > 0 { print("| Type '2' to select a car                  |") } // Man skal ikke have denne mugelighed hvis 'Tabellen' af biler er tom
            print("| Type '3' to skip adding a car             |")
            print("+ ----------------------------------------- +")
            print()
        }
        
        switch !isEdit ? (readLine() ?? "") : "1" {
        case "1":
            if !isEdit {
                car = Car(id: getNewId(type: .Car))
                if let unwrapedCar = car {
                    cars.append(unwrapedCar)
                }
            } else {
                print("Leave the input blank to keep the origional value")
            }
            var temp:String
            
            print("Brand: " + (isEdit ? ("(" + (car?.brand ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                car?.brand = temp
            }
            
            print("Model: " + (isEdit ? ("(" + (car?.model ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                car?.model = temp
            }
            
            print("Vin number: " + (isEdit ? ("(" + (car?.vinNumber ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                car?.vinNumber = temp
            }
            
            print("Reg number: " + (isEdit ? ("(" + (car?.regNumber ?? "") + ")") : ""))
            temp = readLine() ?? ""
            if !(isEdit && temp == "") {
                car?.regNumber = temp
            }
            
            print("ProductionYear: " + (isEdit ? (car?.productionYear != nil ? "(\(car?.productionYear ?? 0))" : "()") : ""))
            if let input = readLine() {
                car?.productionYear = Int(input)
            }
        case "2":
            for car in cars {
                print(car)
            }
            print("Type the id of the car you want to select")
            print()
            if let input = readLine() {
                if let id = Int(input) {
                    car = cars.first { (car) -> Bool in car.id == id }
                }
            }
        case "3": break
        default:
            print("Not a valid option!")
            hasCar = false
        }
    }
    
    return car
}


func createOrder() {
    print("Order description:")
    let description = readLine()
    let order = Order(id: getNewId(type: .Order), car: car(), customer: customer(), description: description ?? "")
    orders.append(order)
}


func editOrder() {
    if let order = selectOrder() {
        var input:String?
        while input != "x" {
            
            print("+ ----------------------------------------- +")
            print("| Type '1' to edit order description        |")
            print("| Type '2' to change order state            |")
            print("| Type '3' to edit the car or add a new car |")
            print("| Type '4' edit the customer                |")
            print("| Type 'x' to exit the function             |")
            print("+ ----------------------------------------- +")
            print()
            
            input = readLine()            
            switch (input ?? "") {
                case "1":
                    print("Leave the input blank to keep the origional description")
                    print("Description: (\(order.orderDescription))")
                    if let description = readLine() {
                        order.orderDescription = description
                    }
                case "2":
                    changeOrderState(order: order)
                case "3":
                    if let car = car(car: order.car) {
                        print(car)
                    }
                case "4":
                    print(customer(customer: order.customer))
                default: break
            }
        }
    }
}

func deleteOrder() {
    if let order = selectOrder() {
        print("Are you sure you want to delete the order? [y/n] (\(order))")
        if readLine() == "y" {
            // for the car asosiated to the order
            if order.car != nil {
                print("Do you want to delete the car? [y/n] (may be used in other orders)   (\(order.car!))") // tjekker lige over at den ikke er nil
                if readLine() == "y" {
                    for i in 0..<cars.count {
                        if cars[i].id == order.car?.id {
                            cars.remove(at: i)
                            break
                        }
                    }
                }
            }
            
            // for the customer asosiated to the order
                print("Do you want to delete the customer? [y/n] (may be used in other orders)   (\(order.customer))")
                if readLine() == "y" {
                    for i in 0..<customers.count {
                        if customers[i].id == order.customer.id {
                            customers.remove(at: i)
                            break
                        }
                    }
                }
            
            // delete the order
            for i in 0..<orders.count {
                if orders[i].id == order.id {
                    orders.remove(at: i)
                    break
                }
            }
        }
    }
}



/*************************************************************************************************************************************************************************************************************
Hovedmenu
*************************************************************************************************************************************************************************************************************/

var input:String?
while input != "x" {
    print("+ ---------------------------------- +")
    print("| Type '1' to create a new order     |")
    print("| Type '2' to filter orders by state |")
    print("| Type '3' change a order's state    |")
    print("| Type '4' edit a order              |")
    print("| Type '5' delete a order            |")
    print("| Type 'x' to exit the program       |")
    print("+ ---------------------------------- +")
    print()
    
    input = readLine()
    switch (input ?? "") {
        case "1":
            createOrder()
            break
        case "2":
            getOrdersByState()
            break
        case "3":
            changeOrderState()
            break
        case "4":
            editOrder()
        case "5":
            deleteOrder()
            break
        default: break
    }
}
