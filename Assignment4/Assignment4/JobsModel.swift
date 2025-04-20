//
//  Jobs.swift
//  Assignment4
//
//  Created by Yash Vipul Naik on 2025-04-07.
//

import Foundation

class JobsModel : Codable {
    
    var jobs : [JobsArrayModel] = []
}

class JobsArrayModel : Codable {
    
    var company : String = ""
    var datePosted : String = ""
    var description : String = ""
    var employmentType : String = ""
    var id : String = ""
    var jobProviders : [JobProvideArrayModel]?
    var location : String = ""
    var salaryRange : String = ""
    var title : String = ""
}

class JobProvideArrayModel : Codable{
    
    init(jobProvider: String, url: String) {
        self.jobProvider = jobProvider
        self.url = url
    }
    var jobProvider : String = ""
    var url : String = ""
}
