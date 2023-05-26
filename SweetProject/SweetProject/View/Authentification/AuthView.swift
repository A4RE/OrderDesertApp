//
//  AuthView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import SwiftUI

struct AuthView: View {
    
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConf = ""
    @State var createAccount: Bool = false
    
    @State private var isTabViewShow = false
    @State private var isShowAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        VStack {
            Text("deseti_from_ledy_Di")
                .fontWeight(.bold)
                .font(.system(size: 18))
                .foregroundColor(Color(UIColor(named: "coffeeWithMilk") ?? .black))
                .hAligh(.center)
            Image("logo")
                .resizable()
                .frame(width: 236, height: 201)
                .padding(.top, 25)
                .hAligh(.center)
            Spacer()
            // block with text Fields
            VStack {
                Text(isAuth ? "Вход" : "Регистрация")
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .foregroundColor(Color("lightSand"))
                    .hAligh(.leading)
                TextField("email", text: $email)
                    .textContentType(.emailAddress)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                    .background(
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 0,
                                             style: .continuous)
                            .stroke(.clear)
                        }
                    )
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                        })
                SecureField("Пароль", text: $password)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                    .background(
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 0,
                                             style: .continuous)
                            .stroke(.clear)
                        }
                    )
                    .overlay(
                        VStack {
                            Spacer()
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                        })
                    .padding(.top, 16)
                if !isAuth {
                    SecureField("Подтверждение пароля", text: $passwordConf)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                        .background(
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 0,
                                                 style: .continuous)
                                .stroke(.clear)
                            }
                        )
                        .overlay(
                            VStack {
                                Spacer()
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundColor(Color(UIColor(named: "lightSand") ?? .black))
                            })
                        .padding(.top, 16)
                }
                //Login Button
                Button {
                    if isAuth {
                        print("Авторизация")
                        AuthService.shared.signIn(email: email, password: password) { result in
                            switch result {
                            case .success(_):
                                isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации \(error.localizedDescription)"
                                isShowAlert.toggle()
                            }
                        }
                    } else {
                        guard password == passwordConf else {
                                                self.alertMessage = "Пароли не совпадают"
                                                self.isShowAlert.toggle()
                                                return
                                            }
                        AuthService.shared.regUser(email: email,
                                                   password: password) { result in
                            switch result {
                            case .success(let user):
                                alertMessage = "Вы зарегистрировались с email: \(user.email!)"
                                self.isShowAlert.toggle()
                                self.email = ""
                                self.password = ""
                                self.passwordConf = ""
                            case .failure(let error):
                                alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                                self.isShowAlert.toggle()
                            
                            }
                        }
                        print("Регистрация прошла успешно")
                    }
                } label: {
                    Text( isAuth ? "Войти" : "Зарегистрироваться")
                        .frame(maxWidth: .infinity,
                               maxHeight: 72)
                        .foregroundColor(.white)
                        .background(Color(UIColor(named: "lightSand") ?? .brown))
                        .foregroundColor(Color(UIColor(named: "coffeeWithMilk") ?? .black))
                        .font(.system(size: 18, weight: .medium))
                        .cornerRadius(20.0)
                        .padding(.bottom, 19)
                        .padding(.top, 19)
                }
                //Register Button
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Создать аккаунт" : "Войти в аккаунт")
                        .frame(maxWidth: .infinity, maxHeight: 72)
                        .foregroundColor(Color(UIColor(named: "lightSand") ?? .brown))
                        .font(.system(size: 18, weight: .medium))
                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color(UIColor(named: "lightSand") ?? .brown)))
                }
            }
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button{} label: {
                    Text("Ок")
                }
            }
            
        }
        .vAligh(.top)
        .padding(20)
        .fullScreenCover(isPresented: $isTabViewShow) {
            
            if AuthService.shared.currentUser?.uid == "CWr4anr9azMzcg5fvMD90TjzU2B3" {
                AdminOrdersView()
            } else {
                let mainTabBarViewModel = MainTabBarViewModel(user: AuthService.shared.currentUser!)
                MainTabBarView(viewModel: mainTabBarViewModel)
            }
        }
    }
    
}


struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
