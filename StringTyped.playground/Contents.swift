//: Playground - noun: a place where people can play

//About: https://realm.io/cn/news/tryswift-andyy-hope-swift-eye-stringly-typed-api/

import UIKit

protocol KeyNamespaceable {
    static func namespace<T: RawRepresentable>(_ key: T) -> String
}

/*
A simple function that does some string interpolation
that combines two objects and separates them with a full stop; the name of the class, and the rawValue of they key
*/

extension KeyNamespaceable {
    static func namespace<T: RawRepresentable>(_ key: T) -> String {
        return "\(Self.self).\(key.rawValue)"
    }
}


protocol BoolDefaultSettable: KeyNamespaceable {
    associatedtype BoolKey: RawRepresentable
}

extension BoolDefaultSettable where BoolKey.RawValue == String {
    
    static func set(_ value: Bool, forKey defaultName: BoolKey) {
        let key = namespace(defaultName)
        print("key:\(key)")
        /*
         log:
            key:Account.isUserLoggedIn
            key:Onboarding.isUserLoggedIn
         */
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func object(forKey defaultName: BoolKey) -> Any? {
        let key = namespace(defaultName)
        return UserDefaults.standard.object(forKey: key)
    }
}

//add context
struct Defaults {
    struct Account: BoolDefaultSettable {
        enum BoolKey: String {
            case isUserLoggedIn
        }
    }
    
    struct Onboarding: BoolDefaultSettable {
        enum BoolKey: String {
            case isUserLoggedIn
        }
    }
}

Defaults.Account.set(true, forKey: .isUserLoggedIn)
Defaults.Onboarding.set(false, forKey: .isUserLoggedIn)

let account = Defaults.Account.object(forKey: .isUserLoggedIn)
let onboarding = Defaults.Onboarding.object(forKey: .isUserLoggedIn)



