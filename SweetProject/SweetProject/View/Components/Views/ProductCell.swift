//
//  ProductCell.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import SwiftUI

struct ProductCell: View {
    var product: Product
    
    @State var uiImage = UIImage(named: "zefir1")
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage!)
                .resizable()
                .frame(width: 250, height: 300)
                .cornerRadius(20)
            VStack (alignment: .leading) {
                Text(product.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color("coffeeWithMilk"))
                Text(product.category)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color("coffeeWithMilk"))
                HStack {
                    Text("Цена:")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("coffeeWithMilk"))
                    Text("\(product.price) Р")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("coffeeWithMilk"))
                }
            }
            .padding(.leading, 10)
            .padding(.bottom, 10)
            .hAligh(.leading)
        }
        .onAppear {
            StorageService.shared.downloadImages(id: self.product.id) { result in
                switch result {
                    
                case .success(let data):
                    if let img = UIImage(data: data) {
                        self.uiImage = img
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .frame(width: 250)
        .background(Color("lightSand"))
        .cornerRadius(20)
    }
}


struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1",
                                     title: "Зефир малиновый",
                                     category: "Зефир",
                                     description: "описание",
                                     sostav: "состав",
                                     imageUrl: "пусто",
                                     price: 400))
    }
}
