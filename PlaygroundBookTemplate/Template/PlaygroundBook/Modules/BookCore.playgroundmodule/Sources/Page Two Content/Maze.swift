//
//  Maze.swift
//  BookCore
//
//  Created by Subhronil Saha on 14/04/21.
//

import Foundation
import SwiftUI

class Maze: ObservableObject {
    
    @Published var map = [
        [ 1,  2,  3,  4,  5,  6,  7,  8],
        [ 9, 10, 11, 12, 13, 14, 15, 16],
        [17, 18, 19, 20, 21, 22, 23, 24],
        [25, 26, 27, 28, 29, 30, 31, 32],
        [33, 34, 35, 36, 37, 38, 39, 40],
        [41, 42, 43, 44, 45, 46, 47, 48],
        [49, 50, 51, 52, 53, 54, 55, 56],
        [57, 58, 59, 60, 61, 62, 63, 64]
    ]
    
    // Visited map:
    // 0 = Not visited
    // 1 = Visited
    // 2 = wall
    // 3 = start point
    // 4 = end point
    @Published var visited = [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
    ]
    
    @Published var walls = [
        [0, 1, 0, 1, 0, 0, 0, 1],
        [0, 0, 0, 1, 0, 0, 1, 1],
        [0, 1, 1, 1, 1, 0, 0, 1],
        [0, 0, 1, 0, 1, 1, 0, 0],
        [0, 0, 1, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 1, 0, 0, 0]
    ]
     
    @Published var stack = [Int]()
    @Published var queue = [Int]()
    @Published var startNode = 1
    @Published var endNode = 64
        
    var gameTimer: Timer?
    @Published var currentNode = 1
    @Published var row = 0
    @Published var col = 0
    @Published var status = "Waiting"
    @Published var statusColor = Color.blue
    var k = 1
    let max = 8
    
    // Constructor
    public init() {

    }
    
    func stopTimer() {
        status = "Done"
        statusColor = Color.green
        gameTimer?.invalidate()
    }
    
    func toggleVisited(row: Int, col: Int) {
        visited[row][col] = (visited[row][col] == 0) ? 1 : 0
    }
    
    func resetVisited() {
        for i in 0..<max {
            for j in 0..<max {
                visited[i][j] = 0
            }
        }
        stack = [Int]()
        queue = [Int]()
    }
    
    @objc func increase() {
        let r = k / 8
        let c = k % 8
        visited[r][c] = 1
        k += 1
    }
    
    //MARK:- BFS
    @objc func bfsUtil() {
                
        if(!queue.isEmpty) {
            let currId = queue.removeFirst()
            let currRow = (currId % max == 0) ? (currId / max - 1) : (currId / max)
            let currCol = (currId % max == 0) ? max-1 : (currId % max - 1)
            
            if walls[currRow][currCol] == 0 {
                
                currentNode = currId
                row = currRow
                col = currCol
                
                // Mark visited
                if(visited[currRow][currCol] == 0) {
                    visited[currRow][currCol] = 1
                }
                
                // If reached destination, stop
                if(currId == endNode) {
                    stopTimer()
                }

                // up
                if(currRow - 1 >= 0) {
                    let neighborId = currId - max
                    let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                    let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
                    if(visited[row][col] == 0 && walls[row][col] == 0) {
                        queue.append(neighborId)
                        visited[row][col] = 1
                    }
                }
                
                // right
                if(currCol + 1 < max) {
                    let neighborId = (currId + 1)
                    let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                    let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
                    if(visited[row][col] == 0 && walls[row][col] == 0) {
                        queue.append(neighborId)
                        visited[row][col] = 1
                    }
                }
                
                // down
                if(currRow + 1 < max) {
                    let neighborId = (currId + max)
                    let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                    let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
                    if(visited[row][col] == 0 && walls[row][col] == 0) {
                        queue.append(neighborId)
                        visited[row][col] = 1
                    }
                }
                
                // left
                if(currCol - 1 >= 0) {
                    let neighborId = (currId - 1)
                    let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                    let col = (neighborId % 8 == 0) ? 7 : (neighborId % 8 - 1)
                    if(visited[row][col] == 0 && walls[row][col] == 0) {
                        queue.append(neighborId)
                        visited[row][col] = 1
                    }
                }
                
            }
            
        } else {
            stopTimer()
        }
                
    }
    
    func bfs() {
        // Add Root element
        queue.append(startNode)
        status = "Searching ..."
        statusColor = Color.yellow
        gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(bfsUtil), userInfo: nil, repeats: true)
        
    }
    
    //MARK:- DFS
    @objc func dfsUtil() {
                
        if(!stack.isEmpty) {
            let currId = stack.popLast()!
            currentNode = currId
            let currRow = (currId % max == 0) ? (currId / max - 1) : (currId / max)
            let currCol = (currId % max == 0) ? max-1 : (currId % max - 1)
            row = currRow
            col = currCol
            
            // Mark visited
            if(visited[currRow][currCol] == 0) {
                visited[currRow][currCol] = 1
            }
            
            // If reached destination, stop
            if(currId == endNode) {
                stopTimer()
            }

            // up
            if(currRow - 1 >= 0) {
                let neighborId = currId - max
                let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
                if(visited[row][col] == 0 && walls[row][col] == 0) {
                    stack.append(neighborId)
                    visited[row][col] = 1
                }
            }
            
            // right
            if(currCol + 1 < max) {
                let neighborId = (currId + 1)
                let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
                if(visited[row][col] == 0 && walls[row][col] == 0) {
                    stack.append(neighborId)
                    visited[row][col] = 1
                }
            }
            
            // down
            if(currRow + 1 < max) {
                let neighborId = (currId + max)
                let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
                if(visited[row][col] == 0 && walls[row][col] == 0) {
                    stack.append(neighborId)
                    visited[row][col] = 1
                }
            }
            
            // left
            if(currCol - 1 >= 0) {
                let neighborId = (currId - 1)
                let row = (neighborId % max == 0) ? (neighborId / max - 1) : (neighborId / max)
                let col = (neighborId % 8 == 0) ? 7 : (neighborId % 8 - 1)
                if(visited[row][col] == 0 && walls[row][col] == 0) {
                    stack.append(neighborId)
                    visited[row][col] = 1
                }
            }
        } else {
            stopTimer()
        }
                
    }
    
    func dfs() {
        // Add Root element
        stack.append(startNode)
        status = "Searching ..."
        statusColor = Color.yellow
        gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(dfsUtil), userInfo: nil, repeats: true)
        
    }
    
}

/*
 
1       2       3       4       5       6       7       8
9       10      11      12      13      14      15      16
17      18      19      20      21      22      23      24
25      26      27      28      29      30      31      32
33      34      35      36      37      38      39      40
41      42      43      44      45      46      47      48
49      50      51      52      53      54      55      56
57      58      59      60      61      62      63      64
 
*/
