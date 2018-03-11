//
//  Question.swift
//  StackOverFlowApp
//
//  Created by jonathan thornburg on 2/27/18.
//  Copyright © 2018 jon-thornburg. All rights reserved.
//

import Foundation

struct Question {
    let title: String
    let score: Int
    let tags: [String]
    let date: Date
    let owner: User?
}

extension Question {
    private enum Keys: String, SerializationKey {
        case title
        case score
        case tags
        case owner
        case date = "creation_date"
    }
    
    init(serialization: Serialization) {
        title = serialization.value(forKey: Keys.title)!
        score = serialization.value(forKey: Keys.score)!
        tags = serialization.value(forKey: Keys.tags)!
        let creationDate: Int = serialization.value(forKey: Keys.date)!
        date = Date(timeIntervalSince1970: TimeInterval(creationDate))
        if let ownerSerialization: Serialization = serialization.value(forKey: Keys.owner) {
            owner = User(serialization: ownerSerialization)
        } else {
            owner = nil
        }
    }
}

struct QuestionsResource: APIResource {
    typealias Model = Question
    
    let methodPath: String = "/questions"
    
    func makeModel(serialization: Serialization) -> QuestionsResource.Model {
        return Question(serialization: serialization)
    }
}
