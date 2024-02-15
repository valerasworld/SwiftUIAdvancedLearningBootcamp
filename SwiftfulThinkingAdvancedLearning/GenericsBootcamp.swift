//
//  GenericsBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 15.02.2024.
//

import SwiftUI

struct StringModel {
    
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    
    @Published var stringModel = StringModel(info: "Hello, World!")
    
    @Published var genericStringModel = GenericModel(info: "Hello, World!")
    @Published var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View> : View {
    
    let content: T
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    
    @StateObject private var vm = GenericsViewModel()
    
    var body: some View {
        VStack {
            GenericView(content: Text("custom content"), title: "New View!")
//            GenericView(title: "New View!")
            
            Text(vm.stringModel.info ?? "No data")
            Text(vm.genericStringModel.info ?? "No data")
            Text(vm.genericBoolModel.info?.description ?? "No data")

                
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}
