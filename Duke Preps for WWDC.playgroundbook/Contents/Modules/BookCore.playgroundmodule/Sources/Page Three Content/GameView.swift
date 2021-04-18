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
                    
                    Text("\(game.status[3])")
                        .foregroundColor(game.statusColor[3])
                        .fontWeight(.bold)

                }


                HStack(spacing: 20) {

                    // Left Philosopher
                    VStack {
                        Button (action: {
                            game.start(player: 2)
                        }) {
                            Image("girl")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        }
                        Text("\(game.status[2])")
                            .foregroundColor(game.statusColor[2])
                            .fontWeight(.bold)
                    }
                    .frame(width: 100, height: 100, alignment: .center)

                    // Dining table
                    ZStack {
                        Image("table-1")
                            .resizable()
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
                    VStack {
                        Button (action: {
                            game.start(player: 0)
                        }) {
                            Image("boy2")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                        }
                        Text("\(game.status[0])")
                            .foregroundColor(game.statusColor[0])
                            .fontWeight(.bold)
                    }
                    .frame(width: 100, height: 100, alignment: .center)

                }

                // Down Philosopher
                VStack {
                    Button (action: {
                        game.start(player: 1)
                    }) {
                        Image("girl2")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                    }
                    
                    Text("\(game.status[1])")
                        .foregroundColor(game.statusColor[1])
                        .fontWeight(.bold)
                }
            
            }
            
            Spacer()
                .frame(height: 40)
            
            //
            VStack(spacing: 25) {
                
                // Semaphore Array
                HStack(spacing: 20) {
                    
                    Text("Binary Semaphore array: ")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .frame(width: 100, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    ForEach(0..<4, id: \.self) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.orange, lineWidth: 3)
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            Text("\(game.forks[i])")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                        
                             
                        }
                    }
                }
                
                // Array of who has it occupied
                HStack(spacing: 20) {
                    
                    Text("Fork users: ")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .frame(width: 100, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    ForEach(0..<4, id: \.self) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.purple, lineWidth: 3)
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            if game.occupants[i] == -1 {
                                Text("-")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                            } else {
                                Image(game.imageNames[game.occupants[i]])
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                            }
                        }
                    }
                }
                
                // Array of blocked users
                HStack(spacing: 20) {
                    
                    Text("Blocked users: ")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .frame(width: 100, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    ForEach(0..<4, id: \.self) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.pink, lineWidth: 3)
                                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            if i < game.blockedQueue.count {
                                Image(game.imageNames[game.blockedQueue[i]])
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
//                                Text("\(game.blockedQueue[i])")
                            }
                             
                        }
                    }
                }
                
                
                HStack {
                    // DEADLOCK
                    if game.blockedQueue.count == 4 {
                        Text("DEADLOCK")
                            .foregroundColor(Color.pink)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                        
                        Button(action: {
                            game.reset()
                        }) {
                            Text("RESET")
                                .foregroundColor(Color.pink)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .underline(true, color: Color.pink)
                        }
                        
                        Button(action: {
                            game.preventDeadlock()
                        }) {
                            Text("SOLVE DEADLOCK")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .underline(true, color: Color.pink)
                        }
                    }
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
