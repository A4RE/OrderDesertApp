//
//  ProfileView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 24.05.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isAuthViewPresented = false
    @State var isQuitAlertShow = false
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Личный кабинет")
                    .foregroundColor(Color(UIColor(named: "coffeeWithMilk") ?? .black))
                    .font(.system(size: 30, weight: .bold))
                    .padding(.horizontal, 20)
                    .hAligh(.leading)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            TextField("Ваша фамилия", text: $viewModel.profile.surname)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                            TextField("Ваше имя", text: $viewModel.profile.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                            TextField("Ваше отчество", text: $viewModel.profile.lastName)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                            HStack {
                                Text("+7")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("coffeeWithMilk"))
                                TextField("Ваш номер телефона", text: $viewModel.profile.phone)
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color("coffeeWithMilk"))
                            }
                            TextField("Ваша почта тут", text: $viewModel.profile.email)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                        }
                        .hAligh(.leading)
                        .padding(.horizontal, 20)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Адрес доставки: ")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                            TextField("Ваш адрес доставки", text: $viewModel.profile.adres)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(Color("coffeeWithMilk"))
                        }
                        .padding(.horizontal, 20)
                        Divider()
                        //Таблица с заказами
                        Text("Ваши заказы")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(Color("coffeeWithMilk"))
                            .hAligh(.leading)
                            .padding(.horizontal, 20)
                        if viewModel.orders.count == 0 {
                            Text("У вас нет заказов")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color("coffeeWithMilk"))
                                .hAligh(.center)
                                .padding(.horizontal, 20)
                        } else {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(viewModel.orders, id: \.id) { order in
                                    OrderCell(order: order)
                                }
                            }
                        }
                    }
                    .vAligh(.top)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Button ("Выйти", role: .destructive) {
                            AuthService.shared.signOut()
                            isAuthViewPresented.toggle()
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(Color("coffeeWithMilk"))
                    }

                }
            }
            .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                AuthView()
            }
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear{
            self.viewModel.getProfile()
            self.viewModel.getOrders()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: UserModel(id: "",
                                                                   name: "Андрей",
                                                                   surname: "Коваленко",
                                                                   lastName: "Алексеевич",
                                                                   phone: "9064634834",
                                                                   email: "aakoval01@gmail.com",
                                                                   adres: "Какой-то адрес тут, придумать лень")))
    }
}
