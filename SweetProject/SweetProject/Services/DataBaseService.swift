//
//  DataBaseService.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("Users")
    }
    
    private var ordersRef: CollectionReference {
        return db.collection("Orders")
    }
    
    private var desertRef: CollectionReference {
        return db.collection("products")
    }
    
    private init() {}
    
    func getPosition(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionsRef = ordersRef.document(orderID).collection("Positions")
        
        positionsRef.getDocuments { qSnap, error in
            if let querySnap = qSnap {
                var positions = [Position]()
                
                for doc in querySnap.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
    }
    
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.ordersRef.getDocuments { qSnap, error in
            
            if let qSnap = qSnap {
                var orders = [Order]()
                for doc in qSnap.documents {
                    if let userID = userID{
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
                    } else { // Для админа
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        
    }

    
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id,
                             positions: order.positions) { result in
                    switch result {
                        
                    case .success(let positions):
                        print(positions.count)
                        completion(.success(order))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func setPositions(to orderId: String, positions: [Position], completion: @escaping (Result<[Position], Error>) -> ()) {
        
        let positionsRef = ordersRef.document(orderId).collection("Positions")
        
        for position in positions {
            positionsRef.document(position.id).setData(position.representation)
        }
        
        completion(.success(positions))
        
    }
    
    func setProfile(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getProfile(by userId: String? = nil, completion: @escaping (Result<UserModel, Error>) -> ()) {
        usersRef.document(userId != nil ? userId!: AuthService.shared.currentUser!.uid).getDocument { docSnapshot, error in
            
            guard let snap = docSnapshot else {return}
            
            guard let data = snap.data() else { return }
            
            guard let id = data["id"]  as? String else { return }
            guard let userName = data["name"] as? String else { return }
            guard let surname = data["surname"] as? String else { return }
            guard let lastName = data["lastName"] as? String else { return }
            guard let phone = data["phone"] as? String else { return }
            guard let email = data["email"] as? String else { return }
            guard let adres = data["adres"] as? String else { return }
            
            let user = UserModel(id: id,
                                 name: userName,
                                 surname: surname,
                                 lastName: lastName,
                                 phone: phone,
                                 email: email,
                                 adres: adres)
            
            completion(.success(user))
            
        }
        
    }
    
    func setProduct(product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()) {
        
        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
                
            case .success(let sizeInfo):
                print(sizeInfo)
                
                self.desertRef.document(product.id).setData(product.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
                
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> ()) {
        
        self.desertRef.getDocuments { qSnap, error in
            
            guard let qSnap = qSnap else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            let docs = qSnap.documents
            
            var products = [Product]()
            
            for doc in docs {
                guard let product = Product(doc: doc) else { return }
                products.append(product)
            }
            
            completion(.success(products))  
        }
        
    }
    
}
