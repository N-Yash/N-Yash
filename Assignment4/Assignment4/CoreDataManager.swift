import Foundation
import UIKit
import CoreData

class CoreDataManager {

    static var shared : CoreDataManager = CoreDataManager()

    // Prevent direct instantiation
    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Assignment4")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Core Data Operations

    func addJobToDB(savedJob : JobsArrayModel) {
        let context = persistentContainer.viewContext

        // Check if the job is already saved to avoid duplicates
        if isJobAlreadySaved(jobId: savedJob.id) {
            print("Job with ID \(savedJob.id) is already saved.")
            return
        }

        guard let savedJobEntity = NSEntityDescription.insertNewObject(forEntityName: "SavedJob", into: context) as? SavedJob else {
            print("Failed to create new SavedJob object.")
            return
        }

        savedJobEntity.company = savedJob.company
        savedJobEntity.datePosted = savedJob.datePosted
        savedJobEntity.employmrntType = savedJob.employmentType
        savedJobEntity.id = savedJob.id
        savedJobEntity.jobDescrption = savedJob.description
        savedJobEntity.location = savedJob.location
        savedJobEntity.salaryRange = savedJob.salaryRange
        savedJobEntity.title = savedJob.title

        // Add JobProviders
        if let providers = savedJob.jobProviders {
            for providerData in providers {
                guard let jobProviderEntity = NSEntityDescription.insertNewObject(forEntityName: "JobProviders", into: context) as? JobProviders else {
                    print("Failed to create new JobProviders object.")
                    continue
                }
                jobProviderEntity.jobProvider = providerData.jobProvider
                jobProviderEntity.url = providerData.url
                jobProviderEntity.jobId = savedJobEntity // Set the relationship
            }
        }

        saveContext()
        print("Job with title '\(savedJob.title)' saved successfully.")
    }

    func getAllSavedJobs() -> [SavedJob] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedJob> = SavedJob.fetchRequest()

        do {
            let savedJobs = try context.fetch(fetchRequest)
            return savedJobs
        } catch {
            print("Failed to fetch saved jobs: \(error)")
            return []
        }
    }

    func deleteSavedJob(jobId: String?) {
        let context = persistentContainer.viewContext
        guard let jobIdToDelete = jobId else {
            print("Job ID is nil, cannot delete.")
            return
        }

        let fetchRequest: NSFetchRequest<SavedJob> = SavedJob.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", jobIdToDelete)

        do {
            let results = try context.fetch(fetchRequest)
            if let jobToDelete = results.first {
                context.delete(jobToDelete)
                saveContext()
                print("Job with ID \(jobIdToDelete) deleted successfully.")
            } else {
                print("Job with ID \(jobIdToDelete) not found.")
            }
        } catch {
            print("Failed to delete saved job: \(error)")
        }
    }

    func isJobAlreadySaved(jobId: String?) -> Bool {
        guard let jobIdToCheck = jobId else {
            return false
        }

        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<SavedJob> = SavedJob.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", jobIdToCheck)

        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to check if job is saved: \(error)")
            return false
        }
    }
}
