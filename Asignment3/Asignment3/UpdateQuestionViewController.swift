//
//  UpdateQuestionViewController.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-28.
//

import UIKit

class UpdateQuestionViewController: UIViewController {

    var selectQuestion: Questions?
        var localModel: Quiz?
        
        
    @IBOutlet weak var lblQuestion: UITextField!
    @IBOutlet weak var lblCorrectAnswer: UITextField!
    @IBOutlet weak var lblOption1: UITextField!
    @IBOutlet weak var lblOption2: UITextField!
    @IBOutlet weak var lblOption3: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localModel = ((UIApplication.shared.delegate) as! AppDelegate).model
        // Do any additional setup after loading the view.
        setupUIForUpdate()
    }
    
    private func setupUIForUpdate() {
        guard let question = selectQuestion else { return } // Exit if no question to update
        lblQuestion.text = question.text
        lblCorrectAnswer.text = question.answers
        lblOption1.text = question.incorrect[0]
        lblOption2.text = question.incorrect[1]
        lblOption3.text = question.incorrect[2]
         // Change button title to "Update"
    }
        
    @IBAction func btnCancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        guard let questionText = lblQuestion.text, !questionText.isEmpty,
              let correctAnswer = lblCorrectAnswer.text, !correctAnswer.isEmpty,
              let incorrect1 = lblOption1.text, !incorrect1.isEmpty,
              let incorrect2 = lblOption2.text, !incorrect2.isEmpty,
              let incorrect3 = lblOption3.text, !incorrect3.isEmpty 
        else {
            showAlert(title: "Missing Information", message: "Please fill in all fields.")
            return
        }

        let answers = [incorrect1, incorrect2, incorrect3]

        if var question = selectQuestion {
                // Update existing question
                question.text = questionText
                question.answers = correctAnswer
                question.incorrect = answers
                localModel?.update(updatedQuiz: question)
        } else {
            let newQuestion = Questions(id: UUID(), text: questionText, answers: correctAnswer, incorrect: answers)
            localModel?.add(newQuiz: newQuestion)
        }

        dismiss(animated: true, completion: nil)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
