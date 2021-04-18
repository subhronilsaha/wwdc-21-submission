//
//  IntroView.swift
//  BookCore
//
//  Created by Subhronil Saha on 18/04/21.
//

import SwiftUI

public struct IntroView: View {
    
    let greetings = ["Hello!", "Hi!", "Hola!", "Bonjour!", "Konnichiwa!", "Namaste!", "Hallo!", "Ciao!"]
    let colors : [Color] = [.blue, .green, .pink, .gray, .orange, .purple, .red, .yellow]
    @State var index = 0
    @State var index1 = 0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    public var body: some View {
        VStack {
                        
            ZStack {
                withAnimation {
                    Text("\(greetings[index])")
                        .font(.title)
                        .foregroundColor(colors[index1])
                        .animation(.default)
                        .onReceive(timer) { date in
                            self.index1 = Int.random(in: 0..<8)
                            self.index = Int.random(in: 0..<8)
                        }
                }
            }.frame(width: 200, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Image("memoji-dev-guy")
                .resizable()
                .frame(width: 200, height: 220)
                .animation(.easeInOut, value: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            Image("Title")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 200)
                .animation(.easeInOut, value: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        
        }
    }
}
