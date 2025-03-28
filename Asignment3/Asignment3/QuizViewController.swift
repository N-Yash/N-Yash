//
//  QuizViewController.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-28.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!
        @IBOutlet weak var btnOption1: CustomRadioButton!
        @IBOutlet weak var btnOption2: CustomRadioButton!
        @IBOutlet weak var btnOption3: CustomRadioButton!
        @IBOutlet weak var btnOption4: CustomRadioButton!
        @IBOutlet weak var progressBar: UIProgressView!
        @IBOutlet weak var btnNext: UIButton!
        @IBOutlet weak var btnBack: UIButton!
        var quiz = Quiz.shared
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            loadQuestion()
            quiz = Quiz.shared
        }
        
        var currentQuestionIndex = 0
        var selectedAnswer: String?

        func setupUI() {
            btnBack.isHidden = true
            btnNext.isEnabled = false
            progressBar.progress = 0.0
        }

        func loadQuestion() {
            guard currentQuestionIndex < quiz.questions.count else {
                showResults()
                return
            }

                let question = quiz.questions[currentQuestionIndex]
                lblQuestion.text = question.text
                let shuffledAnswers = question.shuffledAnswers()

                btnOption1.setTitle(shuffledAnswers[0], for: .normal)
                btnOption2.setTitle(shuffledAnswers[1], for: .normal)
                btnOption3.setTitle(shuffledAnswers[2], for: .normal)
                btnOption4.setTitle(shuffledAnswers[3], for: .normal)

                btnOption1.isSelected = false
                btnOption1.isSelected = false
                btnOption3.isSelected = false
                btnOption4.isSelected = false

                btnNext.isEnabled = false
                btnBack.isHidden = currentQuestionIndex == 0
                progressBar.progress = Float(currentQuestionIndex + 1) / Float(quiz.questions.count)
        }

        @IBAction func answerSelected(_ sender: CustomRadioButton) {
            selectedAnswer = sender.titleLabel?.text
            btnNext.isEnabled = true
            btnOption1.isSelected = (sender == btnOption1)
            btnOption2.isSelected = (sender == btnOption2)
            btnOption3.isSelected = (sender == btnOption3)
            btnOption4.isSelected = (sender == btnOption4)
        }

        @IBAction func btnNextClicked(_ sender: UIButton) {
            if let selected = selectedAnswer, currentQuestionIndex < quiz.questions.count {
                if selected == quiz.questions[currentQuestionIndex].answers {
                    quiz.score += 1
                }
                quiz.userAnswers.append(selected)
            }

            currentQuestionIndex += 1
            loadQuestion()
        }

        @IBAction func btnBackButtonClicked(_ sender: UIButton) {
            currentQuestionIndex -= 1
            if quiz.userAnswers.count > currentQuestionIndex {
                quiz.userAnswers.removeLast()
            }
            if quiz.score > 0 && quiz.userAnswers.count > 0 && quiz.userAnswers[currentQuestionIndex] != quiz.questions[currentQuestionIndex].answers{
                quiz.score -= 1
            }
            loadQuestion()
        }

        func showResults() {
            let alert = UIAlertController(title: "Quiz Results", message: "Your score: \(quiz.score) / \(quiz.questions.count)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
}
