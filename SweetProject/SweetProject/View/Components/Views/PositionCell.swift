//
//  PositionCell.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(position.product.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("coffeeWithMilk"))
            Text("Количество: \(position.countOfCorobok) шт")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("coffeeWithMilk"))
            Text("Цена за 1 единицу товара: \(position.product.price)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("coffeeWithMilk"))
            Text("Сумма: \(position.cost) Р")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("coffeeWithMilk"))
        }
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(position: Position(id: UUID().uuidString,
                                        product: Product(id: UUID().uuidString,
                                                         title: "Малиновый зефир 5",
                                                         category: "Зефир",
                                                         description: "Описание",
                                                         sostav: "состав",
                                                         imageUrl: "zefir1",
                                                         price: 400), countOfCorobok: 3))
    }
}
