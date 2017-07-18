//: Playground - noun: a place where people can play

import UIKit

//MARK: Strongly typed Identifier
struct Person{
    //Implements the Hashable and Equatable so the Identifier can be set as Dictionary keys.
    struct Identifier: RawRepresentable, Hashable, Equatable {
        let rawValue: String
        init(rawValue:String) { self.rawValue = rawValue
        }
    }
    let identifier: Identifier
    var name: String
    var age: Int?
}

struct Building{
    struct Identifier: RawRepresentable, Hashable, Equatable {
        let rawValue: String
        init(rawValue:String) { self.rawValue = rawValue
        }
    }
    let identifier: Identifier
    var title: String
    var owner: Person
}

//Use RawRepresentable so we get the Equatable implementation for free, Hashable is implemented in a protocol extension:
extension RawRepresentable where RawValue : Hashable {
    public var hashValue: Int { return rawValue.hashValue }
}

func sayHelloToPerson(_ person: Person){
    print("You have scrolled to:\(person.name)")
}

//Person.Idenfier is a type just like any other type i.e.: String
func sayHelloToPerson(with id: Person.Identifier){
    print("You have scrolled to person with ID:\(id.rawValue)")
}

let myIdentifier = Person.Identifier(rawValue:"1001")
let buildingIdentifier = Building.Identifier(rawValue:"2001")
let me = Person(identifier:myIdentifier, name: "Upedra", age: 28)
let myHouse = Building(identifier: buildingIdentifier, title: "Bower Residency", owner: me)

sayHelloToPerson(me)
sayHelloToPerson(with: me.identifier)
//Compiler complain when building.identifier passed.
//sayHelloToPerson(with: myHouse.identifier)

//MARK: TypeAlias way

struct Student {
    typealias Identifier = String
    let identifier: Identifier
    var name: String
    var age: Int?
}

//This still doesn't solve the strongly typed identifier. Just as string only
let meAsStudent = Student(identifier: "3001", name: "Upendra", age: 22)

//MARK: Generic way

struct GenericIdentifier<T>: RawRepresentable, Hashable, Equatable{
    let rawValue: String
    init(rawValue: String){self.rawValue = rawValue}
}

protocol Identifiable{
    associatedtype IdentifiableType
    typealias Identifier = GenericIdentifier<IdentifiableType>
}

struct PersonWithGenericType:Identifiable{
    typealias IdentifiableType = PersonWithGenericType
    let identifier: Identifier
    var name: String
    var age: Int?
}


//If you want to work with class, then provide a better helper class
protocol IdentifiableClass: class {
    typealias Identifier = GenericIdentifier<Self>
}

//FIXME: When it implements IdentifiableClass then it keeps giving error: note: did you mean 'Identifier'?
//typealias Identifier = GenericIdentifier<Self>
class PersonClass{
    typealias Identifier = GenericIdentifier<PersonClass>
    let id: Identifier
    var name: String
    var age: Int?
    init() {
        self.id = Identifier(rawValue: "")
        self.name = "toto"
    }
}


