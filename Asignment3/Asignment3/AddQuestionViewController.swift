//
//  AddQuestionViewController.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-21.
//

import UIKit

class AddQuestionViewController: UIViewController {
    @IBOutlet weak var txtQuestion: UITextField!
    @IBOutlet weak var txtCorrectAnswer: UITextField!
    @IBOutlet weak var txtOption1: UITextField!
    @IBOutlet weak var txtOption2: UITextField!
    @IBOutlet weak var txtOption3: UITextField!
    
    var localModel: Quiz?
    override func viewDidLoad() {
        super.viewDidLoad()
        localModel = ((UIApplication.shared.delegate) as! AppDelegate).model

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        guard let questionText = txtQuestion.text, !questionText.isEmpty,
              let correctAnswer = txtCorrectAnswer.text, !correctAnswer.isEmpty,
              let incorrect1 = txtOption1.text, !incorrect1.isEmpty,
              let incorrect2 = txtOption2.text, !incorrect2.isEmpty,
              let incorrect3 = txtOption3.text, !incorrect3.isEmpty 
        else {
            showAlert(title: "Missing Information", message: "Please fill in all fields.")
            return
        }
        let answers = [incorrect1, incorrect2, incorrect3]
        let newQuestion = Questions(id: UUID(), text: questionText, answers: correctAnswer, incorrect: answers)
        localModel?.add(newQuiz: newQuestion)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
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
