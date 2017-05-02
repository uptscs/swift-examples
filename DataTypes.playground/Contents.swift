//: Playground - noun: a place where people can play

import UIKit

var str = "Welcome to Swift Tutorials! Pleae visit www.sharehiring.com for more details."

//Integer Data types

//let negativeInteger : UInt = -1 //will throw the error

//let outofCapacityNumber : Int8 = Int8.max + 1 //will throw the error

//MARK: integer operations and conversion
let thousand : UInt16 = 1000
let oneHundered : Int8 = 2
//let thousandOneHundered = thousand + oneHundered // Will throw the error
let thousandOneHundered = thousand + UInt16(oneHundered) // Need typecasting

//MARK: Boolean
let iamRight = true
let iamAlwaysRight = 1
if iamAlwaysRight {
    print("You seems lost! Ask Siri for Help.");
}