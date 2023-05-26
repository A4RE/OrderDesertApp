//
//  SweetProjectApp.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 27.03.2023.
//

import SwiftUI
import Firebase


@main
struct SweetProjectApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if let user = AuthService.shared.currentUser {
                if user.uid == "CWr4anr9azMzcg5fvMD90TjzU2B3" {
                    AdminOrdersView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBarView(viewModel: viewModel)
                }
            } else {
                AuthView()
            }
        }
    }
}
