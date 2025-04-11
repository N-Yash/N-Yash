//
//  JobsViewControllerTableViewController.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import UIKit

class JobsTableViewController: UITableViewController, JobsDelegate {

    var searchJob: String = ""
    var searchLocation: String = ""
    var searchRemote: String = ""
    var searchJobType: String = ""
    var jobs: [JobsArrayModel] = []
    var selectedJob : JobsArrayModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.jobsDelegate = self
        print(searchJob)
        NetworkManager.shared.fetchJobs(title: searchJob,location: searchLocation,remote: searchRemote,type: searchJobType)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    func networkingDidFinishGettingJobWithObject(jobs: JobsModel) {
        self.jobs = jobs.jobs // Store the fetched jobs
        tableView.reloadData() // Update the table view
        // Update other UI elements with the job data
        for job in self.jobs{
            print(job.title)
        }
    }

    func networkingDidFail() {
        // Handle the error (e.g., display an alert)
        print("Failed to fetch jobs.")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as? JobCustomTableViewCell
        let job = jobs[indexPath.row]
        cell!.jobTitleLabel?.text = job.title
        cell!.locationLabel?.text = job.location
        cell!.salaryLabel?.text = "Salary: " + job.salaryRange
        cell!.jobTypeLabel?.text = "Job Type: " + job.employmentType
        return cell!
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobsDetailsSegue" {
            if let jobsDetailVC = segue.destination as? JobDetailsViewController {
                selectedJob = jobs[tableView.indexPathForSelectedRow?.row ?? 0]
                jobsDetailVC.selectedJobReceived = selectedJob
            }
        }
    }
}
