//
//  EnvironmentProperty.swift
//  PropertyWrappers
//
//  Created by Daniil on 23.08.2022.
//

import SwiftUI


class ViewModel: ObservableObject{
    @Published var data: [String] = []
    
    init(){
        data.append(contentsOf: ["iPad", "Samusung😎", "Xiaomi🤯"])
    }
}


struct EnvironmentProperty: View {
    @StateObject var viewModel: ViewModel = .init()
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.data, id: \.self, content: {item in
                    NavigationLink {
                        EnvironmentSecondView(titleOfButton: item)
                    } label: {
                        Text(item)
                    }
                    
                })
            }
            
            .navigationTitle("Smartphones")
        }.environmentObject(viewModel)
            .accentColor(.white)
    }
}

struct EnvironmentSecondView: View{
    let titleOfButton: String
    
    var body: some View{
        ZStack{
            Color.orange.ignoresSafeArea()
            NavigationLink {
                FinalView()
            } label: {
                Text(titleOfButton)
                    .bold()
                    .foregroundColor(.orange)
                    .padding()
                    .padding(.horizontal)
                    .background(.white)
                    .cornerRadius(30)
            }
        }
    }
}

struct FinalView: View{
    @EnvironmentObject var viewModel: ViewModel
    var body: some View{
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            ScrollView{
                VStack(spacing: 20){
                    ForEach(viewModel.data, id: \.self) { item in
                        Text(item)
                    }
                    .font(.title)
                    Button {
                        viewModel.data.append("Huawei")
                    } label: {
                        Text("Add new authors")
                            .bold()
                            .foregroundColor(.orange)
                            .padding()
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(30)
                    }

                }
            }
            
        }
        
        
    }
}

struct EnvironmentProperty_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentProperty()
        
    }
}
