//
//  JobDetailsViewController.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import UIKit

class JobDetailsViewController: UIViewController {

    var selectedJobReceived : JobsArrayModel? = nil
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobCountryLabel: UILabel!
    @IBOutlet weak var jobSalaryLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    @IBOutlet weak var applyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobTitleLabel.text = selectedJobReceived?.title
        jobCountryLabel.text = selectedJobReceived?.company
        jobSalaryLabel.text = "Salary: " + (selectedJobReceived?.salaryRange ?? "")
        jobTypeLabel.text = "Job Type: " + (selectedJobReceived?.employmentType ?? "")
        jobDescriptionTextView.text = selectedJobReceived?.description
    }

    func numberOfSections(in applyTableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ applyTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedJobReceived?.jobProviders.count ?? 0
    }
    
    func tableView(_ applyTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = applyTableView.dequeueReusableCell(withIdentifier: "apply", for: indexPath) as? ApplyCustomTableViewCell
        
        cell?.applyLinkLable.text = selectedJobReceived?.jobProviders[indexPath.row].jobProvider
        return cell!
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
