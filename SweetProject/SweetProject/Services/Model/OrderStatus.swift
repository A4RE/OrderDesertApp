//
//  OrderStatus.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    
    case newStat = "Новый"
    case cooking = "Готовится"
    case readyToTake = "Готов к выдаче"
    case completeStat = "Выполнен"
    case cancelledStat = "Отменен"
}
