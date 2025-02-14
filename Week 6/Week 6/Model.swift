//
//  Student.swift
//  week6
//
//  Created by Rania Arbash on 2025-02-14.
//

import Foundation

class Student{
    var id: UUID = UUID()
    var name : String = ""
    var email : String = ""
    var imageData : Data?
    
    init(name: String, email: String, imageData: Data? = nil) {
        self.name = name
        self.email = email
        self.imageData = imageData
    }
}

class StudentManager {
    var studentList : [Student] = []
    
    func addNewStudent(newStd : Student){
        studentList.append(newStd)
    }
    
    func deleteOneStudent(idToDelete : UUID){
        studentList.removeAll{ student in
            return student.id == idToDelete
        }
    }
}
