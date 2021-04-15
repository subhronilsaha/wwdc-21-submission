//
//  GameView.swift
//  BookCore
//
//  Created by Subhronil Saha on 15/04/21.
//

import SwiftUI

public struct GameView: View {
    
    let width = UIScreen.main.bounds.width
    @EnvironmentObject var game: DiningGame
    
    public var body: some View {
        
        VStack {

            // Philosophers on a table
            VStack(spacing: 20) {
                
                // Up Philosopher
                VStack {
                    
                    Button (action: {
                        game.start(player: 3)
                    }) {
                        Image("boy")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                    }

                }


                HStack(spacing: 20) {

                    // Left Philosopher
                    Button (action: {
                        game.start(player: 2)
                    }) {
                        Image("girl")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                    }

                    // Dining table
                    ZStack {
                        Circle()
                            .fill(Color(UIColor.brown))
                            .frame(width: 250, height: 250)
                        ForEach(0..<4, id: \.self) { i in
                            Image((game.forks[i] == 0) ? "forkEating" : "fork")
                                .resizable()
                                .frame(width: 15, height: 40)
                                .offset(y: -170)
                                .rotationEffect(.init(degrees: (i == 0) ? 45 : Double(i) * 90 + 45))
                        }
                            
                    }
                    
                    // Right Philosopher
                    Button (action: {
                        game.start(player: 0)
                    }) {
                        Image("boy2")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                    }

                }

                // Down Philosopher
                Button (action: {
                    game.start(player: 1)
                }) {
                    Image("girl2")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
            
            Spacer()
                .frame(height: 80)
            
            //
            VStack {
                
                HStack(spacing: 10) {
                    ForEach(0..<4, id: \.self) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.purple, lineWidth: 5)
                                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            if let img = getImage(i: i), img != "" {
                                Image(img)
                                    .resizable()
                                    .frame(width: 40, height: 40, alignment: .center)
                            } else {
                                Text("-")
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                            }
                             
                        }
                    }
                }
            }
            
            Spacer()
                .frame(height: 80)
            
            Button (action: {
                game.stopPickTimer()
            }) {
                ZStack {
                    Capsule()
                        .fill(Color.pink)
                        .frame(width: 130, height: 60, alignment: .center)
                    Text("INTERRUPT")
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
        }
    }
    
    func getImage(i: Int) -> String {
        var imgName = ""
        
        if game.occupants[i] > -1 {
            imgName = game.imageNames[game.occupants[i]]
        }
        
        return imgName
    }
}
