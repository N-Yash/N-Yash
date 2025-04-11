//
//  JobDetailsViewController.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import UIKit

class JobDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedJobReceived : JobsArrayModel? = nil

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobCountryLabel: UILabel!
    @IBOutlet weak var jobSalaryLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    @IBOutlet weak var applyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedJobReceived?.title ?? "")
        jobTitleLabel.text = selectedJobReceived?.title
        jobCountryLabel.text = selectedJobReceived?.company
        jobSalaryLabel.text = "Salary: " + (selectedJobReceived?.salaryRange ?? "")
        jobTypeLabel.text = "Job Type: " + (selectedJobReceived?.employmentType ?? "")
        jobDescriptionTextView.text = selectedJobReceived?.description
        applyTableView.dataSource = self // Don't forget to set the dataSource
        applyTableView.reloadData()
        applyTableView.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int { // Use the tableView parameter
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // Use the tableView parameter
        return selectedJobReceived?.jobProviders.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // Use the tableView parameter
        let cell = tableView.dequeueReusableCell(withIdentifier: "apply", for: indexPath) as? ApplyCustomTableViewCell

        cell?.applyLinkLable.text = selectedJobReceived?.jobProviders[indexPath.row].jobProvider
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let jobProvider = selectedJobReceived?.jobProviders[indexPath.row],
        let url = URL(string: jobProvider.url) {
            UIApplication.shared.open(url) // Open the URL in the browser
        }

        // Optionally deselect the row for visual feedback
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
