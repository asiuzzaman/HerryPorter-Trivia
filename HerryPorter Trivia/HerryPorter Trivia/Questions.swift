//
//  Questions.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 12/2/25.
//

import Foundation

struct Questions: Codable {
    let id: Int
    let question: String
    var answer: [String: Bool] = [:]
    let book: Int
    let hint: String


    enum QuestionKey: String, CodingKey {
        case id
        case question
        case answer
        case wrong
        case book
        case hint
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionKey.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.question = try container.decode(String.self, forKey: .question)
        self.answer = try container.decode([String : Bool].self, forKey: .answer)
        self.book = try container.decode(Int.self, forKey: .book)
        self.hint = try container.decode(String.self, forKey: .hint)
        let wrongAnswers = try container.decode([String].self, forKey: .wrong)

        let correctAnswer = try container.decode(String.self, forKey: .answer)
        answer[correctAnswer] = true

        for answer in wrongAnswers {
            self.answer[answer] = false
        }

    }
}
