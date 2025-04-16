//
//  NetworkManager.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import Foundation

protocol JobsDelegate {
    func networkingDidFinishGettingJobWithObject ( jobs : JobsModel)
    func networkingDidFail()
}

class NetworkManager {
    static var shared = NetworkManager()
    var jobsDelegate : JobsDelegate?

    func fetchJobs(title : String, location : String, remote : String, type : String) {
        let headers = [
            "x-rapidapi-key": "86a2f3165amshbd732d9ae2172fep1646a8jsn32d3e20d76a4",
            "x-rapidapi-host": "jobs-api14.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://jobs-api14.p.rapidapi.com/v2/list?query=\(title)&location=\(location)&autoTranslateLocation=true&remoteOnly=\(remote)&employmentTypes=\(type)")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.jobsDelegate?.networkingDidFail()
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response: \(httpResponse)")
                    if let data = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let jobsArray = json["jobs"] as? [[String: Any]] { // Check for "jobs" key.
                                let decoder = JSONDecoder()
                                do {
                                    let jobsData = try JSONSerialization.data(withJSONObject: jobsArray, options: [])
                                    let jobs = try decoder.decode([JobsArrayModel].self, from: jobsData)
                                    let jobsModel = JobsModel()
                                    jobsModel.jobs = jobs
                                    DispatchQueue.main.async {
                                        self.jobsDelegate?.networkingDidFinishGettingJobWithObject(jobs: jobsModel)
                                    }
                                } catch {
                                    print("Decoding error: \(error)")
                                    DispatchQueue.main.async {
                                        self.jobsDelegate?.networkingDidFail()
                                    }
                                }
                            } else {
                                print("Invalid JSON format or missing 'jobs' key.")
                                DispatchQueue.main.async {
                                    self.jobsDelegate?.networkingDidFail()
                                }
                            }
                        } catch {
                            print("Error parsing JSON: \(error)")
                            DispatchQueue.main.async {
                                self.jobsDelegate?.networkingDidFail()
                            }
                        }
                    }
                }
            }
        })

        dataTask.resume()
    }
}
