//
//  AboutMeView.swift
//  BookCore
//
//  Created by Subhronil Saha on 17/04/21.
//

import SwiftUI

public struct AboutMeView: View {
            
    public var body: some View {
        
        VStack {
            Image("myphoto")
                .resizable()
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(100)
                .animation(.linear)
            
            Spacer()
                .frame(height: 20)
            
            Text("Hi there! ✌🏼")
                .foregroundColor(.purple)
                .font(.system(size: 40))
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 20)
            
            Text("I'm Subhronil Saha")
                .font(.system(size: 30))
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 30)
            
            Text("And you just finished reading my Swift Playgroundbook! 🎉")
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
            
            VStack {
                
                Spacer()
                    .frame(height: 30)
                
                Text("Thank you!")
                    .foregroundColor(.purple)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 30)
                
                Text("and I hope this book helped you learn Search algorithms and OS Process Synchronisation!")
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                
            }
            
            
        }
        .padding(30)

    }
}

