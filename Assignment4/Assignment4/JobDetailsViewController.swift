//
//  JobDetailsViewController.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import UIKit
import CoreData

class JobDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedJobReceived : JobsArrayModel? = nil
    var isJobSaved: Bool = false
    var savedJobEntity: NSManagedObject?

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
        setupNavigationBar()
        checkIfJobIsSaved()
        applyTableView.dataSource = self
        applyTableView.delegate = self
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

    func setupNavigationBar() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(saveJobButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }

    func checkIfJobIsSaved() {
        guard let jobId = selectedJobReceived?.id else { return }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobArray")
        fetchRequest.predicate = NSPredicate(format: "id == %@", jobId)

        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            if let savedJob = results.first {
                isJobSaved = true
                savedJobEntity = savedJob
                updateSaveButtonImage()
            } else {
                isJobSaved = false
                updateSaveButtonImage()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    @objc func saveJobButtonTapped() {
        if isJobSaved {
            unsaveJob()
        } else {
            saveJobToCoreData()
        }
    }

    func saveJobToCoreData() {
        guard let selectedJob = selectedJobReceived,
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let jobEntity = NSEntityDescription.entity(forEntityName: "JobArray", in: managedContext)!
        let job = NSManagedObject(entity: jobEntity, insertInto: managedContext)

        job.setValue(selectedJob.title, forKey: "title")
        job.setValue(selectedJob.salaryRange, forKey: "salaryRanage")
        job.setValue(selectedJob.location, forKey: "location")
        job.setValue(selectedJob.description, forKey: "jobDescription")
        job.setValue(selectedJob.id, forKey: "id")
        job.setValue(selectedJob.employmentType, forKey: "employmentType")
        job.setValue(selectedJob.datePosted, forKey: "datePosted")
        job.setValue(selectedJob.company, forKey: "company")

        // Handle JobProviders
        let jobProvidersData = selectedJob.jobProviders
        // Create a mutable set to hold the JobProvider entities
        let jobProvidersSet = NSMutableSet()
        let providerEntity = NSEntityDescription.entity(forEntityName: "JobProvider", in: managedContext)!

        for providerData in jobProvidersData {
            let jobProvider = NSManagedObject(entity: providerEntity, insertInto: managedContext)
            jobProvider.setValue(providerData.jobProvider, forKey: "jobProvider")
            jobProvider.setValue(providerData.url, forKey: "url")
            jobProvidersSet.add(jobProvider)
        }
        // Assuming a to-many relationship named 'jobProviders' in JobArray
        job.setValue(jobProvidersSet, forKey: "jobProviders")


        do {
            try managedContext.save()
            isJobSaved = true
            savedJobEntity = job
            updateSaveButtonImage()
            print("Job saved successfully!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func unsaveJob() {
        guard let savedJob = savedJobEntity else { return }
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Need to fetch the JobArray entity to remove associated JobProviders
        if let jobId = savedJob.value(forKey: "id") as? String {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "JobArray")
            fetchRequest.predicate = NSPredicate(format: "id == %@", jobId)

            do {
                let results = try context.fetch(fetchRequest) as! [NSManagedObject]
                if let jobToDelete = results.first {
                    // Remove associated JobProviders (assuming a cascading delete rule is NOT set)
                    if let providers = jobToDelete.value(forKey: "jobProviders") as? NSSet {
                        for provider in providers {
                            context.delete(provider as! NSManagedObject)
                        }
                    }
                    // Then delete the JobArray entity
                    context.delete(jobToDelete)
                }
            } catch let error as NSError {
                print("Could not fetch job to unsave. \(error), \(error.userInfo)")
                return
            }
        }

        do {
            try context.save()
            isJobSaved = false
            savedJobEntity = nil
            updateSaveButtonImage()
            print("Job unsaved successfully!")
        } catch let error as NSError {
            print("Could not unsave. \(error), \(error.userInfo)")
        }
    }

    func updateSaveButtonImage() {
        let imageName = isJobSaved ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: imageName)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedJobReceived?.jobProviders.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apply", for: indexPath) as! ApplyCustomTableViewCell
        if let jobProvider = selectedJobReceived?.jobProviders[indexPath.row] {
            cell.applyLinkLable.text = jobProvider.jobProvider
        }
        return cell
    }

    // MARK: - Table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let jobProvider = selectedJobReceived?.jobProviders[indexPath.row],
           let url = URL(string: jobProvider.url) {
            UIApplication.shared.open(url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
