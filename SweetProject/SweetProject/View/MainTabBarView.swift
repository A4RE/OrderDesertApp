//
//  MainTabBarView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import SwiftUI

struct MainTabBarView: View {
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                CatalogView()
            }
            .tabItem {
                Image(systemName: "house")
                    .font(.system(size: 20))
                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                Text("Главная")
                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
            }
            NavigationStack {
                CategoriesOfDeserts()
            }
            .tabItem {
                Image(systemName: "list.bullet")
                    .font(.system(size: 20))
                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                Text("Главная")
                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
            }
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    Image(systemName: "cart")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                    Text("Корзина")
                        .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                }
            ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "",
                                                                       name: "",
                                                                       surname: "", lastName: "",
                                                                       phone: "",
                                                                       email: "",
                                                                       adres: "")))
                .tabItem {
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                    Text("Профиль")
                        .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                }
        }
        .tint(Color("coffeeWithMilk"))
    }
}
