//
//  MainTabBarViewModel.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}
