//
//  UserDefaultsKey+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/09.
//

import Foundation

/// A generic key for `UserDefaults`. Extend this type to define custom user defaults keys.
///
/// ```
/// extension UserDefaultsKey {
///   static var myKey: Key<String> {
///     return "myKey"
///   }
///
///   static var anotherKey: Key<Int> {
///     return "anotherKey"
///   }
/// }
/// ```
struct UserDefaultsKey<T> {
    typealias Key<T> = UserDefaultsKey<T>
    let key: String
}

extension UserDefaultsKey: ExpressibleByStringLiteral {
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.init(key: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(key: value)
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(key: value)
    }
}

extension UserDefaultsKey {
    static var plate: Key<String> {
        return "plate"
    }
}
