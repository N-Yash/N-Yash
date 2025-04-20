import UIKit
import CoreData

class JobDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedJobReceived : JobsArrayModel? = nil
    var isJobSaved: Bool = false
    @IBOutlet weak var saveButton: UIButton!

    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobCountryLabel: UILabel!
    @IBOutlet weak var jobSalaryLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var jobDescriptionTextView: UITextView!
    @IBOutlet weak var applyTableView: UITableView!
    @IBOutlet weak var datePosted: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedJobReceived?.title ?? "")
        setupUI()
        applyTableView.dataSource = self
        applyTableView.delegate = self
        checkIfJobIsSaved()
    }

    func setupUI() {
        jobTitleLabel.text = selectedJobReceived?.title
        jobCountryLabel.text = selectedJobReceived?.company
        jobSalaryLabel.text = "Salary: " + (selectedJobReceived?.salaryRange ?? "")
        jobTypeLabel.text = "Job Type: " + (selectedJobReceived?.employmentType ?? "")
        jobDescriptionTextView.text = selectedJobReceived?.description
        datePosted.text = selectedJobReceived?.datePosted
        jobDescriptionTextView.isEditable = false
    }

    func checkIfJobIsSaved() {
        if let jobId = selectedJobReceived?.id, CoreDataManager.shared.isJobAlreadySaved(jobId: jobId) {
            isJobSaved = true
            saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            isJobSaved = false
            saveButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        if let jobToSave = selectedJobReceived {
            if !isJobSaved {
                CoreDataManager.shared.addJobToDB(savedJob: jobToSave)
                saveButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                isJobSaved = true
                let alert = UIAlertController(title: "Job Saved", message: "This job has been saved to your saved jobs.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            } else {
                // Directly use jobToSave.id as it's a non-optional String
                CoreDataManager.shared.deleteSavedJob(jobId: jobToSave.id)
                saveButton.setImage(UIImage(systemName: "heart"), for: .normal)
                isJobSaved = false
                let alert = UIAlertController(title: "Job Unsaved", message: "This job has been removed from your saved jobs.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Could not save job details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedJobReceived?.jobProviders?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apply", for: indexPath) as! ApplyCustomTableViewCell
        if let jobProvider = selectedJobReceived?.jobProviders?[indexPath.row] {
            cell.applyLinkLable.text = jobProvider.jobProvider
        }
        return cell
    }

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let jobProvider = selectedJobReceived?.jobProviders?[indexPath.row],
           let url = URL(string: jobProvider.url) {
            UIApplication.shared.open(url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
