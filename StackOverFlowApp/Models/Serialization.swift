//
//  Serialization.swift
//  StackOverFlowApp
//
//  Created by jonathan thornburg on 3/4/18.
//  Copyright © 2018 jon-thornburg. All rights reserved.
//

import Foundation

typealias Serialization = [String:Any]

protocol SerializationKey {
    var stringValue: String { get }
}

extension RawRepresentable where RawValue == String {
    var stringValue: String {
        return rawValue
    }
}

protocol SerializationValue {}

extension Bool: SerializationValue {}
extension Int: SerializationValue {}
extension String: SerializationValue {}
extension Dictionary: SerializationValue {}
extension Array: SerializationValue {}

extension Dictionary where Key == String, Value: Any {
    func value<V: SerializationValue>(forKey key: SerializationKey) -> V? {
        return self[key.stringValue] as? V
    }
}
