//
//  SearchJobsViewController.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import UIKit

class SearchJobsViewController: UIViewController {

 
    
    @IBOutlet weak var job: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var remote: UIButton!
    @IBOutlet weak var jobType: UIButton!

    var inputJob: String = ""
    var inputLocation: String = ""
    var inputRemote: String = "False"
    var inputJobType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPullDownButton()
    }

    func setupPullDownButton() {
        // Remote Button Setup
        let option1Remote = UIAction(title: "False") { action in
            self.remote.setTitle(action.title, for: .normal)
            self.inputRemote = action.title.lowercased()
        }

        let option2Remote = UIAction(title: "True") { action in
            self.remote.setTitle(action.title, for: .normal)
            self.inputRemote = action.title.lowercased()
        }

        let remoteTypeMenu = UIMenu(title: "Choose Remote Option", children: [option1Remote, option2Remote])
        remote.menu = remoteTypeMenu
        remote.showsMenuAsPrimaryAction = true
        remote.setTitle(option1Remote.title, for: .normal)

        // Job Type Button Setup
        let option1JobType = UIAction(title: "Full Time") { action in
            self.jobType.setTitle(action.title, for: .normal)
            self.inputJobType = self.removeWhitespacesFromString(mStr: action.title).lowercased()
            print(self.inputJobType)
        }

        let option2JobType = UIAction(title: "Part Time") { action in
            self.jobType.setTitle(action.title, for: .normal)
            self.inputJobType = self.removeWhitespacesFromString(mStr: action.title).lowercased()
        }

        let option3JobType = UIAction(title: "Intern") { action in
            self.jobType.setTitle(action.title, for: .normal)
            self.inputJobType = action.title.lowercased()
        }

        let option4JobType = UIAction(title: "Contract") { action in
            self.jobType.setTitle(action.title, for: .normal)
            self.inputJobType = action.title.lowercased()
        }

        let jobTypeMenu = UIMenu(title: "Choose Job Type", children: [option1JobType, option2JobType, option3JobType, option4JobType])
        jobType.menu = jobTypeMenu
        jobType.showsMenuAsPrimaryAction = true
        jobType.setTitle("Select Job Type", for: .normal)
    }

    @IBAction func searchBtnClicked(_ sender: Any) {
        inputJob = job.text ?? ""
        inputLocation = location.text ?? ""

        // Validation
        if inputJob.isEmpty {
            showAlert(title: "Error", message: "Please enter a job title.")
            return
        }

        if inputLocation.isEmpty {
            showAlert(title: "Error", message: "Please enter a location.")
            return
        }

        if inputJobType.isEmpty {
            showAlert(title: "Error", message: "Please select a job type.")
            return
        }
    }

    func removeWhitespacesFromString(mStr: String) -> String {
        let chr = mStr.components(separatedBy: .whitespaces)
        let resString = chr.joined()
        return resString
    }
    
    @IBAction func savedJobsBtnClicked(_ sender: Any) {
        
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobsSegue" {
            if let jobsTableVC = segue.destination as? JobsTableViewController {
                jobsTableVC.searchJob = inputJob
                jobsTableVC.searchLocation = inputLocation
                jobsTableVC.searchRemote = inputRemote
                jobsTableVC.searchJobType = inputJobType
            }
        }
        if segue.identifier == "showSavedJobDetailsSegue"{
            
        }
    }
}
