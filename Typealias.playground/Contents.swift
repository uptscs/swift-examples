//: Playground - noun: a place where people can play

import UIKit

//https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Declarations.html#//apple_ref/swift/grammar/typealias-declaration

//Just another typedef but with more flexibility and adds a lot of value in swift. Mostly when block/closure asked to pass as function parameter.

//A class contains the functions which requires closure as parameters
//It's mostly used when we want to do asynchronous communication and notify back once operation is complete (through closure).

struct User{
    let Identifier: String
    var name: String
    var age: Int?
}

class API{
    //Complete gets called when API communication with server is done.
    //Error is used to populate the local validation error and notify the caller.
    func getUser(userID: String, complete: ((_ response: User,_ error: NSError?) -> Void),
                 error:((_ error: NSError) -> Bool)? = nil){
        //Expect this to be the local validation
        if userID != "1001" {
            let validationError = NSError(domain: "Given UserId doesn't exist in server", code: 1001, userInfo: nil)
            if let localError = error{
                localError(validationError)
            }
        }else{
            //Expect this as server call and returns the valid User instance.
            let user = User(Identifier: "1001", name: "Upendra", age: 28)
            complete(user, nil)
        }
    }
}

//Without typealias earth is a difficult place.
let api = API()
api.getUser(userID: "1001", complete: { (user, error) in
    if let apiError = error{
        print("Error while trying to fetch the user from API, reason: \(apiError.localizedDescription)")
    }else{
        print("Welcome: \(user.name)")
    }
}) { (error) -> Bool in
    print("Error while trying to fetch user, reason: \(error.localizedDescription)")
    return false;
}


//With typealias it's quite easy.
typealias APICompletionHandler = (_ response: User,_ error: NSError?) -> Void;
typealias UserErrorHandler = (_ error: NSError) -> Bool;

class APINew {
    func getUser(userID: String, complete:(APICompletionHandler)? = nil,
                 error:(UserErrorHandler)? = nil){
        //Expect this to be the local validation
        if userID != "1001" {
            let validationError = NSError(domain: "Given UserId doesn't exist in server", code: 1001, userInfo: nil)
            if let localError = error{
                localError(validationError)
            }
        }else{
            //Expect this as server call and returns the valid User instance.
            let user = User(Identifier: "1001", name: "Upendra", age: 28)
            if let completionHandler = complete{
                completionHandler(user, nil)
            }
        }
    }
}

let newUserCompletionHander: APICompletionHandler = { user, error in
    if let apiError = error{
        print("Error while trying to fetch the user from API, reason: \(apiError.localizedDescription)")
    }else{
        print("Welcome New: \(user.name)")
    }
}

let newUserError: UserErrorHandler = { (error) -> Bool in
    print("Error while trying to fetch user, reason: \(error.localizedDescription)")
    return false;
}

// It looks amazing to detach the code from actual call and makes it a lot easier to pass them around as code block.
//Amazing handling of asynchronous communication with APIs
let newAPI = APINew()
newAPI.getUser(userID: "1001", complete: newUserCompletionHander, error: newUserError)
