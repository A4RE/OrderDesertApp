//
//  DetProdView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import SwiftUI

struct DetProdView: View {
    
    @State var viewModel: ProdDetViewModel
    @State var count = "6 шт"
    @State var countOfCorobok = 1
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                Image(uiImage: self.viewModel.image)
                    .resizable()
                    .frame(width: 240, height: 320)
                    .hAligh(.center)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 11) {
                        Text(viewModel.product.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("coffeeWithMilk"))
                            .hAligh(.leading)
                            .padding(.top, 9)
                            .padding(.horizontal, 20)
                        HStack(spacing: 10) {
                            Text("Категория: ")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("coffeeWithMilk"))
                            Text(viewModel.product.category)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                        }
                        .padding(.horizontal, 20)
                        Text("Описание")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("coffeeWithMilk"))
                            .padding(.horizontal, 20)
                        Text(viewModel.product.description)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("coffeeWithMilk"))
                            .padding(.horizontal, 20)
                        Text("Состав")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("coffeeWithMilk"))
                            .padding(.horizontal, 20)
                        Text(viewModel.product.sostav)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("coffeeWithMilk"))
                            .padding(.horizontal, 20)
                        HStack {
                            Text("Цена: ")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                                .padding(.horizontal, 20)
                            Text("\(viewModel.getPrice(count: self.count)) Р")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                        }
                        if viewModel.product.category == "Зефир" {
                            HStack {
                                Stepper("Количество коробок", value: $countOfCorobok, in: 1...5)
                                Text("\(self.countOfCorobok)")
                                    .padding(.leading)
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 20)
                            .foregroundColor(Color("coffeeWithMilk"))
                            Text("Выберите число зефирок в одной коробке")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal, 20)
                                .foregroundColor(Color("coffeeWithMilk"))
                            Picker("Количество", selection: $count) {
                                ForEach(viewModel.count, id: \.self){ item in
                                    Text(item)
                                        .foregroundColor(Color("coffeeWithMilk"))
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal, 20)
                        }
                        Spacer()
                    }
                    
                }
                Button {
                    var position = Position(id: UUID().uuidString,
                                            product: viewModel.product,
                                            countOfCorobok: self.countOfCorobok)
                    position.product.price = viewModel.getPrice(count: count)
                    
                    CartViewModel.shared.addPosition(position)
                    print("Товар добавлен в корзину")
                } label: {
                    Text("Добавить в корзину")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 327, height: 72)
                        .background(Color("coffeeWithMilk"))
                        .cornerRadius(20)
                        .padding(.top, 20)
                }
                
            }
            .onAppear {
                self.viewModel.getImage()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}


struct DetProdView_Previews: PreviewProvider {
    static var previews: some View {
        DetProdView(viewModel: ProdDetViewModel(product: Product(id: "1",
                                                                 title: "Зефир малиновый",
                                                                 category: "Зефир",
                                                                 description: "Описание",
                                                                 sostav: "Состав",
                                                                 imageUrl: "zefi1",
                                                                 price: 400)))
    }
}


