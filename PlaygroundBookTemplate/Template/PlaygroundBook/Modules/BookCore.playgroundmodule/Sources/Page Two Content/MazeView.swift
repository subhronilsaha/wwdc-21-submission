//
//  MazeView.swift
//  BookCore
//
//  Created by Subhronil Saha on 13/04/21.
//

import SwiftUI

public struct MazeView: View {
    
    @EnvironmentObject var maze: Maze
    @State var mode = -1 // 0 = start, 1 = end
    
    public init() {
        
    }
    
    public var body: some View {
        VStack(spacing: 10){
            
            Spacer()
            
            //MARK:- Board
            ForEach(0..<8, id: \.self) { row in
                HStack(spacing: 10){
                    ForEach(0..<8, id: \.self) { col in
                        // OTHER
                        if maze.visited[row][col] == 0 {
                            Button (action: {
                                if self.mode == 0 && maze.walls[row][col] == 0 {
                                    maze.startNode = maze.map[row][col]
                                } else if self.mode == 1 && maze.walls[row][col] == 0 {
                                    maze.endNode = maze.map[row][col]
                                }
                            }) {
                                
                                ZStack {
                                    //Text("\(maze.map[row][col])")
                                    if(maze.map[row][col] == maze.startNode) {
                                        Image("boy")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    } else if(maze.map[row][col] == maze.endNode) {
                                        Image("dog")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    } else if(maze.walls[row][col] >= 1) {
                                        Image(maze.blockerImg[maze.walls[row][col]])
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    } else {
                                        Circle()
                                            .foregroundColor(Color.white)
                                            .frame(width: 40, height: 40, alignment: .center)
                                    }
                                }
                            }

                        } else {
                            Button (action: {
                                if self.mode == 0 && maze.walls[row][col] == 0 {
                                    maze.startNode = maze.map[row][col]
                                } else if self.mode == 1 && maze.walls[row][col] == 0 {
                                    maze.endNode = maze.map[row][col]
                                }
                            }) {
                                ZStack {
                                   
//                                    Text("\(maze.map[row][col])")
//                                        .foregroundColor(Color.white)
                                    if(maze.map[row][col] == maze.startNode) {
                                        Image("boy")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    } else if(maze.map[row][col] == maze.endNode) {
                                        Image("dog")
                                            .resizable()
                                            .frame(width: 40, height: 40, alignment: .center)
                                    } else if(maze.finalPath.contains(maze.map[row][col])){
                                        Circle()
                                            .foregroundColor(Color.yellow)
                                            .frame(width: 40, height: 40, alignment: .center)
                                    }
                                    else {
                                        Circle()
                                            .foregroundColor(Color.blue)
                                            .frame(width: 40, height: 40, alignment: .center)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            //MARK:- Action Buttons
            VStack {
                
                HStack {
                    
                    Text("Pick a: ")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    // PICK START NODE Button
                    Button(action: {
                        self.mode = 0
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.pink)
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("Source")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    
                    // PICK END NODE Button
                    Button(action: {
                        self.mode = 1
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.pink)
                                .frame(width: 120, height: 40, alignment: .center)
                            
                            Text("Destination")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    // DFS Button
                    Button(action: {
                        maze.dfs()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.blue)
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("DFS")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    
                    // BFS Button
                    Button(action: {
                        maze.bfs()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.orange)
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("BFS")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    
                    // AStar Button
                    Button(action: {
                        maze.dijkstra()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color(UIColor(red: 0.24, green: 0.70, blue: 0.44, alpha: 1.00)))
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("Dijkstra")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    
                    // AStar Button
                    Button(action: {
                        maze.astar()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.purple)
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("A-Star")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    
                    // STOP TIMER Button
                    Button(action: {
                        maze.stopTimer()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.pink)
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("STOP")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                    
                    // RESET GRID Button
                    Button(action: {
                        maze.resetVisited()
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color.pink)
                                .frame(width: 100, height: 40, alignment: .center)
                            
                            Text("RESET")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            
            Spacer()
                .frame(height: 20)
            
            VStack {
                
                HStack {
                    Text("Status: ")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Text("\(maze.status)")
                        .foregroundColor(maze.statusColor)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                
                Spacer()
                    .frame(height: 20)
                
                Text("Current Node: \(maze.currentNode) | Coordinates: (\(maze.row), \(maze.col))")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                
                Spacer()
                    .frame(height: 20)
                
                HStack() {

                    Text("Visited Nodes: ")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    
                    Text("\(maze.visitedCount)")
                        .foregroundColor(.green)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                }

//                Text("Queue for BFS")
//                    .font(.system(size: 20))
//                    .fontWeight(.bold)
//                HStack() {
//                    ForEach(0..<maze.queue.count, id: \.self) { index in
//                        Text("\(maze.queue[index])")
//                    }
//                }
            }
            
            Spacer()
            
        }
    }
}

