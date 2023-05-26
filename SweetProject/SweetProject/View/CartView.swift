//
//  CartTestView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        VStack{
            Text("Корзина")
                .hAligh(.leading)
                .padding(.horizontal, 20)
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Color("coffeeWithMilk"))
                .padding(.top, 20)
                .padding(.bottom, 10)
            if viewModel.positions.count == 0 {
                HStack(spacing: 3) {
                    Image(systemName: "cart.fill")
                        .font(.system(size: 20))
                    Text("Ваша корзина пуста")
                        .font(.system(size: 20, weight: .semibold))
                }
                .foregroundColor(Color("coffeeWithMilk"))
                .hAligh(.center)
                .vAligh(.center)
            } else {
                List {
                    ForEach(viewModel.positions, id: \.id) { position in
                        PositionCell(position: position)
                            .swipeActions {
                                Button {
                                    viewModel.positions.removeAll { pos in
                                        pos.id == position.id
                                    }
                                } label: {
                                    Text("Удалить")
                                }.tint(.red)

                            }
                    }
                }
                HStack {
                    Text("Итого: ")
                    Spacer()
                    Text("\(self.viewModel.cost) Р")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color("coffeeWithMilk"))
                .padding(.horizontal, 20)
                Button {
                    print("Заказать")
                    
                    var order = Order(userID: AuthService.shared.currentUser!.uid,
                                      date: Date(),
                                      status: OrderStatus.newStat.rawValue)
                    
                    order.positions = self.viewModel.positions
                    
                    DatabaseService.shared.setOrder(order: order) { result in
                        switch result {
                            
                        case .success(let order):
                            print(order.cost)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                } label: {
                    Text("Заказать")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(.white))
                        .frame(width: 327, height: 72)
                        .background(Color("lightSand"))
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                }
                
            }
            
        }
        .vAligh(.top)
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
    }
}

struct CartTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CartView(viewModel: CartViewModel.shared)
        }
    }
}
