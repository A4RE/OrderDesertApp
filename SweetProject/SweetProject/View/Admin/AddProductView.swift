//
//  AddProductView.swift
//  SweetProject
//
//  Created by Андрей Коваленко on 25.05.2023.
//

import SwiftUI

struct AddProductView: View {
    
    @State private var showImagePicker = false
    @State private var image = UIImage(named: "zefir1")!
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var sostav: String = ""
    @State private var price: Int? = nil
    @State private var isPopular: Bool = false
    
    private var categories = ["Зефир", "Торт", "Пирожные", "Маршмеллоу", "Печенье"]
    @State private var selectedCategory = "Зефир"
    
    @Environment (\.dismiss) var dismiss
    
    
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Добавить десерт")
                    .hAligh(.leading)
                    .padding(.horizontal, 20)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("coffeeWithMilk"))
                    .padding(.bottom, 20)
                    .padding(.top, 10)
                VStack (spacing: 8) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 150, height: 220)
                        .cornerRadius(20)
                        .onTapGesture {
                            showImagePicker.toggle()
                        }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Название десерта:")
                            TextField("Название", text: $title)
                        }
                        HStack {
                            Text("Выберите категорию: ")
                            Picker("Категории", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { cat in
                                    Text(cat)
                                }
                            }
                            .pickerStyle(.menu)
                            .accentColor(Color("coffeeWithMilk"))
                        }
                        
                        HStack {
                            Text("Описание десерта:")
                            TextField("Описание", text: $description)
                        }
                        HStack {
                            Text("Состав десерта:")
                            TextField("Состав", text: $sostav)
                        }
                        HStack{
                            Text("Цена десерта, Р: ")
                            TextField("Цена", value: $price, format: .number)
                                .keyboardType(.numberPad)
                        }
                    }
                    .foregroundColor(Color("coffeeWithMilk"))
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    Button {
                        
                        guard let price = price else {
                            print("Невозможно извлечь цену из TextField")
                            return
                        }
                        let product = Product(id: UUID().uuidString,
                                              title: title,
                                              category: selectedCategory,
                                              description: description,
                                              sostav: sostav,
                                              price: price)
                        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
                            print("Невозможно извлечь изображение")
                            return
                        }
                        DatabaseService.shared.setProduct(product: product, image: imageData) { result in
                            switch result {
                                
                            case .success(let product):
                                print(product.title)
                                dismiss()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        
                    } label: {
                        Text("Добавить десерт")
                            .frame(width: 327,
                                   height: 72)
                            .background(Color(UIColor(named: "lightSand") ?? .brown))
                            .foregroundColor(Color(UIColor(named: "coffeeWithMilk") ?? .black))
                            .font(.system(size: 18, weight: .medium))
                            .cornerRadius(20.0)
                            .padding(.bottom, 19)
                            .padding(.top, 19)
                    }
                    .padding(.horizontal, 20)
                }
                .vAligh(.top)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
