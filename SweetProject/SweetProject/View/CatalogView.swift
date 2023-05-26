//
//  CatalogView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel = CatalogViewModel()
    
    var body: some View {
        VStack {
            Text("Deserti from Ledy Di")
                .hAligh(.leading)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .font(.system(size: 30, weight: .heavy))
                .foregroundColor(Color("coffeeWithMilk"))
            ScrollView(.vertical, showsIndicators: false){
                Text("Откройте для себя новое измерение вкуса.\nДесерты, которые поражают и вдохновляют.\nЗаказывайте и наслаждайтесь!")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color("coffeeWithMilk"))
                    .hAligh(.leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                //Block with All deserts
                Text("Все десерты")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(UIColor(named: "coffeeWithMilk") ?? .black))
                    .hAligh(.leading)
                    .padding(.horizontal, 20)
                    .foregroundColor(Color("coffeeWithMilk"))
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(viewModel.deserts, id: \.id) { item in
                            NavigationLink  {
                                
                                let viewModel = ProdDetViewModel(product: item)
                                
                                DetProdView(viewModel: viewModel)
                            } label: {
                                ProductCell(product: item)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear{
            self.viewModel.getProducts()
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CatalogView()
        }
    }
}
