//
//  User.swift
//  StackOverFlowApp
//
//  Created by jonathan thornburg on 3/2/18.
//  Copyright © 2018 jon-thornburg. All rights reserved.
//

import Foundation

struct User {
    let name: String?
    let profileImageURL: URL?
    let reputation: Int?
}

extension User {
    private enum Keys: String, SerializationKey {
        case reputation
        case name = "display_name"
        case profileImage = "profile_image"
    }
    
    init(serialization: Serialization) {
        name = serialization.value(forKey: Keys.name)
        reputation = serialization.value(forKey: Keys.reputation)
        if let url: String = serialization.value(forKey: Keys.profileImage) {
            profileImageURL = URL(string: url)
        } else {
            profileImageURL = nil
        }
    }
}

struct UsersResource: APIResource  {
    
    typealias Model = User
    
    var methodPath: String = "/users"
    
    func makeModel(serialization: Serialization) -> User {
        return User(serialization: serialization)
    }
    
    
}
// Alternative approach using functional programming
//struct User: JSONDecodable {
//    let id: Int
//    let name: String
//    let email: String
//
//    static func create(id: Int)(name: String)(email: String) -> User {
//        return User(id: id, name: name, email: email)
//    }
//
//    static func decode(json: JSON) -> User? {
//        return JSONObject(json) >>> { d in
//            User.create <^>
//                d["id"]    >>> JSONInt    <*>
//                d["name"]  >>> JSONString <*>
//                d["email"] >>> JSONString
//        }
//}

