//
//  StateAndObservedProperties.swift
//  PropertyWrappers
//
//  Created by Daniil on 22.08.2022.
//

import SwiftUI

// MARK: - Struct

struct FruitModel: Identifiable{
    let id: String = UUID().uuidString
    let name: String
    var count: Int
}
// MARK: - ViewModel
class FruitsViewModel: ObservableObject{
    @Published var fruits: [FruitModel] = [FruitModel]()
    @Published var isLoading: Bool = true
    
    init(){
        getPosts()
    }
    func getPosts(){
        
        isLoading = true
        var fruit1 = FruitModel(name: "Banana", count: 6)
        var fruit2 = FruitModel(name: "Apple", count: 34)
        var fruit3 = FruitModel(name: "Strawberry", count: 12)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            [fruit1,fruit2,fruit3].forEach { fruit in
                self.fruits.append(fruit)
            }
            self.isLoading = false
            
        }
        
    }
    
    func deletePosts(index: IndexSet){
        fruits.remove(atOffsets: index)
    }
}

// MARK: - View

struct StateAndObservedProperties: View {
    @StateObject var fruitsViewModel: FruitsViewModel = FruitsViewModel()
    
    var body: some View {
        NavigationView{
            List{
                if fruitsViewModel.isLoading {
                    ProgressView()
                }
                else {
                    ForEach(fruitsViewModel.fruits) { fruit in
                        HStack{
                            Text("\(fruit.count)")
                                .foregroundColor(.red)
                            Text(fruit.name)
                        }
                    }
                    .onDelete(perform: fruitsViewModel.deletePosts)
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Fruits Menu")
            .navigationBarItems(trailing: NavigationLink(destination: SecondView(fruits: fruitsViewModel), label: {
                Image(systemName: "arrow.right")
                    .font(.headline)
                    .foregroundColor(.black)
            }))
        }
        
    }
}

struct SecondView: View{
    @ObservedObject var fruits: FruitsViewModel
    var body: some View{
        ZStack{
            Color.green.ignoresSafeArea(.all)
            VStack{
                ForEach(fruits.fruits) { fruit in
                    HStack{
                        Text(fruit.name)
                        Text("\(fruit.count)")
                    }
                }
                .foregroundColor(.white)
                Button("Take one from all fruits") {
                    var newArr = [FruitModel]()
                    for i in fruits.fruits{
                        newArr.append(FruitModel(name: i.name, count: i.count - 1))
                    }
                    fruits.fruits = newArr
 //                    fruits.fruits.append(FruitModel(name: "Chocolate", count: 11))
                }
                .padding(.all)
                .padding(.horizontal)
                .background(Color.purple)
                .cornerRadius(15)
                
                
                
                
            }
        }
    }
}

struct StateAndObservedProperties_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(fruits: FruitsViewModel())
    }
}
