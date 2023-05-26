//
//  Position.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import Foundation
import FirebaseFirestore

struct Position: Identifiable {
    var id: String
    var product: Product
    var countOfCorobok: Int
    var cost: Int {
        return product.price * self.countOfCorobok
    }
    
    var representation: [String : Any] {
        var repres = [String: Any]()
        
        repres["id"] = id
        repres["countOfCorobok"] = countOfCorobok
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = cost
        
        return repres
    }
    
    internal init(id: String, product: Product, countOfCorobok: Int){
        self.id = id
        self.product = product
        self.countOfCorobok = countOfCorobok
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        
        let product: Product = Product(id: "",
                                       title: title,
                                       category: "",
                                       description: "",
                                       sostav: "",
                                       imageUrl: "",
                                       price: price)
        
        guard let countOfCorobok = data["countOfCorobok"] as? Int else { return nil }
        
        self.id = id
        self.product = product
        self.countOfCorobok = countOfCorobok
        
    }
}
