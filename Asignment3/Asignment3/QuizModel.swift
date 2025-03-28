//
//  QuestionModel.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-21.
//

import Foundation
class Quiz {
    
    static var shared : Quiz = Quiz()
    var delagate : QuestionBankDelegate?
    
    var questions: [Questions] = [
        Questions(
            id: UUID(),
            text: "What is the capital of France?",
            answers: "Paris",
            incorrect: ["London", "Berlin", "Madrid"]
        ),
        Questions(
            id: UUID(),
            text: "Which planet is known as the Red Planet?",
            answers: "Mars",
            incorrect: ["Venus", "Jupiter", "Saturn"]
        ),
        Questions(
            id: UUID(),
            text: "What is 2 + 2?",
            answers: "4",
            incorrect: ["3", "5", "6"]
        ),
        Questions(
            id: UUID(),
            text: "Who painted the Mona Lisa?",
            answers: "Leonardo da Vinci",
            incorrect: ["Michelangelo", "Raphael", "Donatello"]
        ),
        Questions(
            id: UUID(),
            text: "What is the largest mammal?",
            answers: "Blue whale",
            incorrect: ["Elephant", "Giraffe", "Hippopotamus"]
        )
    ]
    var currentQuestionIndex = 0
    var userAnswers: [String] = []
    var score = 0

   
    func calculateAverage() -> Double {
        guard !questions.isEmpty else {
            return 0.0
        }
        return Double(score) / Double(questions.count) * 100.0
    }
    
    func add(newQuiz : Questions) {
        print("inAdd", newQuiz)
        self.questions.append(newQuiz)
        print(questions)
        delagate?.didAddQuestion()
    }
    
    func update(updatedQuiz: Questions) {
        if let index = self.questions.firstIndex(where: { $0.id == updatedQuiz.id }) {
            self.questions[index] = updatedQuiz
            print("Question updated: \(updatedQuiz)")
            self.delagate?.didUpdateQuestion()
        } else {
            print("Question with ID \(updatedQuiz.id) not found for update.")
        }
    }
}
