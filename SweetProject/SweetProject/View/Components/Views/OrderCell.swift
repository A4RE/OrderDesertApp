//
//  OrderCell.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import SwiftUI

struct OrderCell: View {
    
    var order: Order
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Дата заказа: \(order.date.dateAndTimeToString())")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("coffeeWithMilk"))
                Text("Сумма заказа: \(order.cost) Р")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("coffeeWithMilk"))
                Text("Статус заказа: \(order.status)")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("coffeeWithMilk"))
            }
            .hAligh(.leading)
            .padding(.leading, 20)
            .frame(width: 353, height: 104)
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
                .foregroundColor(Color("lightSand")))
            .cornerRadius(10)
        }
    }
}
