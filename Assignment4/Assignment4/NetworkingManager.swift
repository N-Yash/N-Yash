//
//  NetworkingManager.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-04.
//

import Foundation

class NetworkingManager{
 
    static var shared = NetworkingManager()
    
    func fetchJobs() {
        let headers = [
            "x-rapidapi-key": "c992b5ce61msh855b85f5ecb80e2p1f26c2jsn7bb3562a47ae",
            "x-rapidapi-host": "jobs-api14.p.rapidapi.com"
        ]

        let urlString = "https://jobs-api14.p.rapidapi.com/v2/list?query=Web%20Developer&location=Canada&autoTranslateLocation=true&remoteOnly=false&employmentTypes=fulltime%3Bparttime%3Bintern%3Bcontractor&x-rapidapi-key=c992b5ce61msh855b85f5ecb80e2p1f26c2jsn7bb3562a47ae"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response: \(httpResponse)")
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            var decoder = JSONDecoder()
                            do {
                               var jobObject = try decoder.decode(JobsModel.self, from: data)
                                
                                DispatchQueue.main.async {
                                    
                                    self.weatherDelegate?.networkingDidFinishGettingWeatherWithObject(jobs: jobObject)
                                    
                                }
                                
                            }catch {
                                print (error)
                            }
                        }
                    } catch {
                        print("JSON parsing error: \(error)")
                    }
                }
            }
        })

        dataTask.resume()
    }
}
