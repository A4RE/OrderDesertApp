//
//  ProdDetViewModel.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import Foundation
import UIKit

class ProdDetViewModel: ObservableObject {
    @Published var product: Product
    @Published var count = ["6 шт", "9 шт", "12 шт"]
    @Published var countOfCorobok = 0
    @Published var image = UIImage(named: "zefir1")!
    
    init(product: Product) {
        self.product = product
        
    }
    func getPrice(count: String) -> Int {
        switch count {
        case "6 шт": return product.price
        case "9 шт": return Int(Double(product.price) * 1.5)
        case "12 шт": return Int(Double(product.price) * 1.75)
        default: return 0
        }
    }
    
    func getImage() {
        StorageService.shared.downloadImages(id: product.id) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
