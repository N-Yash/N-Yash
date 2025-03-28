//
//  QuestionModel.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-28.
//

import Foundation

import Foundation

struct Questions {
    let id: UUID
    var text: String
    var answers: String
    var incorrect: [String]
    
    func shuffledAnswers() -> [String] {
        var allAnswers = incorrect
        allAnswers.append(answers)
        return allAnswers.shuffled()
    }
    
    init(id: UUID, text: String, answers: String, incorrect: [String]) {
        self.id = id
        self.text = text
        self.answers = answers
        self.incorrect = incorrect
    }
}
