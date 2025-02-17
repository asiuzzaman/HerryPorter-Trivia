//
//  Game.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 13/2/25.
//

import SwiftUI

@MainActor
class Game: ObservableObject {
    private var allQuestions: [Question] = []
    private var answeredQuestion: [Int] = []

    var filteredQuestions: [Question] = []
    var currentQuestion = Constants.previewQeustion
    var answers: [String] = []
    var correctAnswer: String {
        currentQuestion.answer.first(where: {$0.value == true })!.key
    }

    init() {
        decodeQuestions()
    }

    func newQuestion() {
        if filteredQuestions.isEmpty { return }

        if answeredQuestion.count == filteredQuestions.count {
            answeredQuestion = []
        }

        var potentialQuestoins = filteredQuestions.randomElement()!

        while answeredQuestion.contains(potentialQuestoins.id) {
            potentialQuestoins = filteredQuestions.randomElement()!
        }

        currentQuestion = potentialQuestoins
        answers = []

        for answer in currentQuestion.answer.keys {
            answers.append(answer)
        }

        answers.shuffle()

        
    }

    func correct() {
        answeredQuestion.append(currentQuestion.id)
        // TODO: Update the score too
    }

    func filteredQuestions(to books: [Int]) {
        filteredQuestions =  allQuestions.filter { books.contains($0.book) }
    }

    private func decodeQuestions() {
        if let url = Bundle.main.url(forResource: "trivia", withExtension: "json") {

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                allQuestions = try decoder.decode([Question].self, from: data)
                filteredQuestions = allQuestions
            }
            catch {
                print("Error while fetching jOSN data")
            }
        }
    }
}
