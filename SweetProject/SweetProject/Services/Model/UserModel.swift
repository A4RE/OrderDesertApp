//
//  UserModel.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import Foundation

struct UserModel: Identifiable {
    var id: String
    var name: String
    var surname: String
    var lastName: String
    var phone: String
    var email: String
    var adres: String
    
    
    var representation: [String : Any] {
        var repres = [String : Any]()
        
        repres["id"] = self.id
        repres["name"] = self.name
        repres["surname"] = self.surname
        repres["lastName"] = self.lastName
        repres["phone"] = self.phone
        repres["email"] = self.email
        repres["adres"] = self.adres
        
        return repres
    }
}
