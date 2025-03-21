//
//  QuestionModel.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-21.
//

import Foundation

struct Question{
    let id : UUID
    var text : String
    var options : [String]
    var correctAnswerIndex: Int
    
    init(id: UUID = UUID(), text: String, options: [String], correctAnswerIndex: Int) {
        self.id = id
        self.text = text
        self.options = options
        self.correctAnswerIndex = correctAnswerIndex
    }
}

class QuizManager{
    static let shared = QuizManager()
    
    private init(){}
    
    private var questions: [Question] = []
    
    func addQuestion(text: String, option: [String], correctAnswerIndex: Int){
        let newQuestion = Question(text: text, options: option, correctAnswerIndex: correctAnswerIndex)
        questions.append(newQuestion)
    }
    
    func getAllQuestions() -> [Question]{
        return questions
    }
    
    func updateQuestion(id: UUID, newText: String, newOpton: [String], newCorrectAnswerIndex: Int) -> Bool{
        if let index = questions.firstIndex(where: { $0.id == id}) {
            questions[index].text = newText
            questions[index].options = newOpton
            questions[index].correctAnswerIndex = newCorrectAnswerIndex
            return true
        }
        return false
    }
}
