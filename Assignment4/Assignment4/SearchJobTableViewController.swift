//
//  SearchJobTableViewController.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-19.
//

import UIKit

class SearchJobTableViewController: UITableViewController {

    var savedJobs: [SavedJob] = []
    var selectedSavedJob: SavedJob? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSavedJobs()
        print(savedJobs[0].title ?? "")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSavedJobs()
    }

    func fetchSavedJobs() {
        savedJobs = CoreDataManager.shared.getAllSavedJobs()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedJobs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath) as? JobCustomTableViewCell
        let job = savedJobs[indexPath.row]
        cell?.jobTitleLabel?.text = job.title
        cell?.locationLabel?.text = job.location
        cell?.salaryLabel?.text = "Salary: \(job.salaryRange ?? "")"
        cell?.jobTypeLabel?.text = "Job Type: \(job.employmrntType ?? "")"
        return cell!
}

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let jobId = savedJobs[indexPath.row].id
            CoreDataManager.shared.deleteSavedJob(jobId: jobId)
            savedJobs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSavedJobDetailsSegue",
           let vc = segue.destination as? JobDetailsViewController,
           let indexPath = tableView.indexPathForSelectedRow {

            let saved = savedJobs[indexPath.row]

            let converted = JobsArrayModel()
            converted.id = saved.id ?? ""
            converted.company = saved.company ?? ""
            converted.datePosted = saved.datePosted ?? ""
            converted.description = saved.jobDescrption ?? ""
            converted.employmentType = saved.employmrntType ?? ""
            converted.location = saved.location ?? ""
            converted.salaryRange = saved.salaryRange ?? ""
            converted.title = saved.title ?? ""

            var providers: [JobProvideArrayModel] = []
            do {
                if let jobProvidersSet = saved.jobProvider,
                   let jobProvidersArray = jobProvidersSet.allObjects as? [JobProviders] {
                    providers = jobProvidersArray.map {
                        JobProvideArrayModel(jobProvider: $0.jobProvider ?? "", url: $0.url ?? "")
                    }
                }
            }

            converted.jobProviders = providers
            vc.selectedJobReceived = converted
        }
    }

}
