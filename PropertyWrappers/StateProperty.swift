//
//  ContentView.swift
//  PropertyWrappers
//
//  Created by Daniil on 22.08.2022.
//

import SwiftUI

struct StateProperty: View {
    // MARK: - State properties
    @State var mainTitle: String = "Main title"
    @State var backgroundColor: Color = .red
    @State var countOfTaps = 0
    
    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea(.all)
            VStack(spacing: 20){
                
                Text(mainTitle)
                    .font(.title)
                Text("Count: \(countOfTaps)")
                HStack(spacing: 20){
                    Button("Button 1") {
                        countOfTaps += 1
                        backgroundColor = .green
                    }
                    Button("Button 2") {
                        countOfTaps -= 1
                        backgroundColor = .purple
                    }
                }
            }
            
            .foregroundColor(.white)
        }
        
    }
}

struct StateProperty_Previews: PreviewProvider {
    static var previews: some View {
        StateProperty()
    }
}
