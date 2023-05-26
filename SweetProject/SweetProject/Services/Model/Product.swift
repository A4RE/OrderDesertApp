//
//  Product.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import Foundation
import FirebaseFirestore


struct Product {
    var id: String
    var title: String
    var category: String
    var description: String
    var sostav: String
    var imageUrl: String = ""
    var price: Int

    var representation: [String : Any] {
        var repres = [String: Any]()
        
        repres["id"] = self.id
        repres["title"] = self.title
        repres["category"] = self.category
        repres["description"] = self.description
        repres["sostav"] = self.sostav
        repres["price"] = self.price
        
        return repres
    }
    
    internal init(id: String = UUID().uuidString, title: String, category: String, description: String, sostav: String, imageUrl: String = "", price: Int) {
        self.id = id
        self.title = title
        self.category = category
        self.description = description
        self.sostav = sostav
        self.imageUrl = imageUrl
        self.price = price
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let category = data["category"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let sostav = data["sostav"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        
        self.id = id
        self.title = title
        self.category = category
        self.description = description
        self.sostav = sostav
        self.price = price
    }
    
    
    
}
