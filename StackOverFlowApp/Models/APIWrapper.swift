//
//  APIWrapper.swift
//  StackOverFlowApp
//
//  Created by jonathan thornburg on 3/2/18.
//  Copyright © 2018 jon-thornburg. All rights reserved.
//

import Foundation

struct APIWrapper {
    let items: [Serialization]
}

extension APIWrapper {
    private enum Keys: String, SerializationKey {
        case items
    }
    
    init(serialization: Serialization) {
        items = serialization.value(forKey: Keys.items) ?? []
    }
}

struct APIWrapperResource: APIResource {
    
    typealias Model = APIWrapper
    
    var methodPath: String = ""
    
    func makeModel(serialization: Serialization) -> APIWrapper {
        return APIWrapper(serialization: serialization)
    }
}
