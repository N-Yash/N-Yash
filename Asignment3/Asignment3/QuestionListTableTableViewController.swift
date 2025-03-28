//
//  QuestionListTableTableViewController.swift
//  Asignment3
//
//  Created by Yash Vipul Naik on 2025-03-21.
//

import UIKit

class QuestionListTableTableViewController: UITableViewController, QuestionBankDelegate{
    func didAddQuestion() {
        questions = localModel?.questions ?? []
        tableView.reloadData()
    }
    
    func didUpdateQuestion() {
        questions = localModel?.questions ?? []
        tableView.reloadData()
    }
    
    var localModel: Quiz?
    var questions: [Questions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localModel = ((UIApplication.shared.delegate) as! AppDelegate).model
        questions = localModel?.questions ?? []
        Quiz.shared.delagate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return localModel?.questions.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellTableViewCell
        let question = questions[indexPath.row]
        
        cell.lblQuestion?.text = question.text
        cell.lblCorrectAnswer?.text = question.answers
        cell.lblOption1.text = question.incorrect[0]
        cell.lblOption2.text = question.incorrect[1]
        cell.lblOption3.text = question.incorrect[2]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "updateQuestion"{
            if let UpdateVC = segue.destination as? UpdateQuestionViewController{
                print("To Update View")
                let localModel = self.localModel
                let index  = tableView.indexPathForSelectedRow?.row ?? 0
                print(localModel?.questions[index])
                UpdateVC.selectQuestion = localModel?.questions[index]
                        
            }
                    
        }
    }


}
