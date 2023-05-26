//
//  CatalogViewModel.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {
    static let shared = CatalogViewModel()
    
    @Published var deserts = [Product]()
    
    func getProducts() {
        DatabaseService.shared.getProducts { result in
            switch result {
                
            case .success(let products):
                self.deserts = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
