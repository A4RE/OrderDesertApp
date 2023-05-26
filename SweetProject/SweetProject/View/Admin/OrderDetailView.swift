//
//  OrderDetailView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import SwiftUI

struct OrderDetailView: View {
    
    @StateObject var viewModel: OrderDetailViewModel
    
    var statuses: [String] {
        var sts = [String]()
        for status in OrderStatus.allCases {
            sts.append(status.rawValue)
        }
        return sts
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("\(viewModel.user.surname) \(viewModel.user.name) \(viewModel.user.lastName)")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color("coffeeWithMilk"))
            Text("+7 \(viewModel.user.phone)")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color("coffeeWithMilk"))
            Text("Адрес доставки: \(viewModel.user.adres)")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color("coffeeWithMilk"))
            Text("Сумма заказа: \(viewModel.order.cost) Р")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color("coffeeWithMilk"))
            HStack {
                Text("Статус заказа: ")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color("coffeeWithMilk"))
                Picker("Статус заказа", selection: $viewModel.order.status){
                    ForEach(statuses, id: \.self) { status in
                        Text(status)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(Color("coffeeWithMilk"))
                .onChange(of: viewModel.order.status) { newStatus in
                    DatabaseService.shared.setOrder(order: viewModel.order) { result in
                        switch result {
                        case .success(let order):
                            print(order.status)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear{
            viewModel.getUserData()
        }
        List {
            ForEach(viewModel.order.positions, id: \.id) { position in
                PositionCell(position: position)
                }
            }
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(viewModel: OrderDetailViewModel(order: Order(userID: "", date: Date(), status: "Новый")))
    }
}
