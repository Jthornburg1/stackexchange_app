//
//  APIResourceProtocol.swift
//  StackOverFlowApp
//
//  Created by jonathan thornburg on 3/10/18.
//  Copyright © 2018 jon-thornburg. All rights reserved.
//

import Foundation

protocol APIResource {
    associatedtype Model
    var methodPath: String { get }
    func makeModel(serialization: Serialization) -> Model
}

extension APIResource {
    var url: URL {
        let baseURL = "https://api.stackexchange.com/2.2"
        let site = "site=stackoverflow"
        let order = "order=desc"
        let sorting = "sort=votes"
        let tags = "tagged=ios"
        let url = baseURL + methodPath + "?" + order + "&" + sorting + "&" + tags + "&" + site
        return URL(string: url)!
    }
    
    func makeModel(data: Data) -> [Model]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return nil }
        guard let jsonSerialization = json as? Serialization else { return nil }
        let apiWrapper = APIWrapper(serialization: jsonSerialization)
        return apiWrapper.items.map(makeModel(serialization:))
    }
}
