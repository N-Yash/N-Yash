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
    
    let quizManager = QuizManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        if txtQuestion.text == "" && txtOption1.text == "" && txtOption2.text == "" && txtOption3.text == "" && txtCorrectAnswer.text == "" {
            let alert = UIAlertController(title: "Enter Every Value", message: "Please enter value for each and evry text field.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default,handler: nil))
            present(alert,animated: true,completion: nil)
        }
        else{
            quizManager.addQuestion(text: txtQuestion.text ?? "", option: [txtCorrectAnswer.text ?? "", txtOption1.text ?? "", txtOption2.text ?? "", txtOption3.text ?? ""], correctAnswerIndex: 0)
            self.dismiss(animated: true)
        }
    }
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true)
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
