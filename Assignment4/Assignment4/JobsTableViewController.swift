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
        selectedJob = jobs[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showJobsDetailsSegue" {
            if let jobsDetailVC = segue.destination as? JobDetailsViewController {
                jobsDetailVC.selectedJobReceived = selectedJob
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
