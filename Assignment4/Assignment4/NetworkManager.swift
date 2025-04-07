//
//  NetworkManager.swift
//  Assignment4
//
//  Created by Yash on 2025-04-06.
//
import Foundation

class NetworkManager{
    
    static var shared = NetworkManager()
    
    func fetchJobData() {
        let headers = [
            "x-rapidapi-key": "c992b5ce61msh855b85f5ecb80e2p1f26c2jsn7bb3562a47ae",
            "x-rapidapi-host": "jobs-api14.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://jobs-api14.p.rapidapi.com/v2/list?query=Web%20Developer&location=United%20States&autoTranslateLocation=true&remoteOnly=false&employmentTypes=fulltime%3Bparttime%3Bintern%3Bcontractor")! as URL,
                                             cachePolicy: .useProtocolCachePolicy,
                                             timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                    if let data = data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            print(json)
                        } catch {
                            print("Error decoding JSON: \(error)")
                        }
                    }
                }
            }
        })

        dataTask.resume()
    }
}
