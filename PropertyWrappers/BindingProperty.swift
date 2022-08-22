//
//  BindingProperty.swift
//  PropertyWrappers
//
//  Created by Daniil on 22.08.2022.
//

import SwiftUI

struct BindingProperty: View {
    @State var backgroundColor: Color = .red
    @State var title: String = "Title"
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20){
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                
                ButtonView(backgroundColor: $backgroundColor, title: $title)
            }
                
        
        }
    }
}


struct ButtonView: View{
    @Binding var backgroundColor: Color
    @Binding var title: String
    @State var buttonBackgroundColor: Color = .black
    var body: some View{
        Button("Touch me") {
            backgroundColor = .pink
            title = "Title has changed"
            buttonBackgroundColor = .yellow
        }
        .padding(.all)
        .padding(.horizontal)
        
        .background(buttonBackgroundColor)
        .cornerRadius(15)
        .foregroundColor(.white)
        
        
        
    }
}

struct BindingProperty_Previews: PreviewProvider {
    static var previews: some View {
        BindingProperty()
    }
}
