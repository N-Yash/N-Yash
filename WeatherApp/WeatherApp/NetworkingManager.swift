//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Yash Vipul Naik on 2025-03-14.
//

import Foundation

class NetworkingManager{
    
    static var shared = NetworkingManager()
    
    func getAllCitiesFromAPI(searchTerm : String){
        
        let url = URL(string: "http://gd.geobytes.com/AutoCompleteCity?&q=\(searchTerm)")!
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
            //check if there is error
            guard let error = error else{
                print(error)
                return
            }
            
            //chceck if there is response not between 200 and 299 ==> no data
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else{
                print("There is no good response")
                return
            }
            
            //I have the data ===> I can decode it
            if let goodData = data {
                var json = String(data: goodData, encoding: .utf8)
                print(json)
            }
        }
        task.resume()
        
    }
}
