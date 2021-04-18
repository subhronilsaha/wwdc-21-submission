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
    
    @Published var openList = [Int]()
    @Published var closedList = [Int]()
    @Published var f = Array(repeating: 0, count: 65)
    @Published var g = Array(repeating: 0, count: 65)
    @Published var h = Array(repeating: 0, count: 65)
    
    @Published var startNode = 1
    @Published var endNode = 64
    @Published var finalPath = [Int]()
    @Published var parents = Array(repeating: 0, count: 65)
    
    @Published var distance = Array(repeating: 100, count: 65)
    @Published var priQueue = [Int]()
    
    var gameTimer: Timer?
    let blockerImg = ["", "tree", "house", "tree-2"]
    
    @Published var currentNode = 1
    @Published var row = 0
    @Published var col = 0
    @Published var status = "Waiting"
    @Published var statusColor = Color.blue
    @Published var visitedCount = 0
    var k = 1
    let max = 8
    
    // Constructor
    public init() {
        //
        setBlockers()
    }
    
    func setBlockers() {
        for i in 0..<max {
            for j in 0..<max {
                if walls[i][j] == 1 {
                    walls[i][j] = Int.random(in: 1..<blockerImg.count)
                }
            }
        }
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
        finalPath = [Int]()
        openList = [Int]()
        closedList = [Int]()
        f = Array(repeating: 0, count: 65)
        g = Array(repeating: 0, count: 65)
        h = Array(repeating: 0, count: 65)
        parents = Array(repeating: 0, count: 65)
        distance = Array(repeating: 100, count: 65)
        priQueue = [Int]()
        visitedCount = 0
    }
    
//    @objc func increase() {
//        let r = k / 8
//        let c = k % 8
//        visited[r][c] = 1
//        k += 1
//    }
    
    func getRow(currId: Int) -> Int {
        return (currId % max == 0) ? (currId / max - 1) : (currId / max)
    }
    
    func getColumn(currId: Int) -> Int {
        return (currId % max == 0) ? max-1 : (currId % max - 1)
    }
    
    //MARK:- Trace Path
    func tracePath(node: Int) {
        var path = [Int]()
        var currNode = node
        path.append(currNode)
        
        while currNode != startNode {
            let parent = parents[currNode]
            path.append(parent)
            currNode = parent
        }
        
        finalPath = path
    }
    
    //MARK:- A Star Search

    func aStarRep(node: Int, parent: Int, goal: Int) {
        
        let row = getRow(currId: node)
        let col = getColumn(currId: node)
        let goalRow = getRow(currId: goal)
        let goalCol = getColumn(currId: goal)
        
        // if not reachable or in closed list
        if walls[row][col] >= 1 || closedList.contains(node) {
            return
        }
        
        // if not in openlist
        if !openList.contains(node) {
            openList.append(node) // add to openlist
            parents[node] = parent // set currents parent
            g[node] = g[parent] + 1
            let xDiff = Int(abs(row - goalRow))
            let yDiff = Int(abs(col - goalCol))
            h[node] = xDiff > yDiff ? xDiff : yDiff
            f[node] = g[node] + h[node]
        }
        else {
            let gNewVal = g[parent] + 1
            
            if gNewVal < g[node] {
                parents[node] = parent
                g[node] = g[parent] + 1
                let xDiff = Int(abs(row - goalRow))
                let yDiff = Int(abs(col - goalCol))
                h[node] = xDiff > yDiff ? xDiff : yDiff
                f[node] = g[node] + h[node]
            }
        }
        
    }
    
    @objc func aStarUtil() {
              
        if openList.isEmpty || closedList.contains(endNode) {
            
            stopTimer()
            tracePath(node: endNode)
            
            return
            
        } else {
            
            // Sort openList by minimum f value
            openList.sort {
                f[$0] < f[$1]
            }
            
            // get current node
            let currId = openList[0]
            openList.removeFirst()

            // Append it to closedList
            closedList.append(currId)
            
            let currRow = getRow(currId: currId)
            let currCol = getColumn(currId: currId)
            
            visited[currRow][currCol] = 1
            visitedCount += 1
                            
            currentNode = currId
            row = currRow
            col = currCol

            // top
            if(currRow - 1 >= 0) {
                let neighborId = currId - max
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // top-right
            if(currRow - 1 >= 0 && currCol + 1 < max) {
                let neighborId = currId - (max-1)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // right
            if(currCol + 1 < max) {
                let neighborId = (currId + 1)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // bottom right
            if(currCol + 1 < max && currRow + 1 < max) {
                let neighborId = (currId + max + 1)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // bottom
            if(currRow + 1 < max) {
                let neighborId = (currId + max)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // bottom left
            if(currRow + 1 < max && currCol - 1 >= 0) {
                let neighborId = (currId + max - 1)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // left
            if(currCol - 1 >= 0) {
                let neighborId = (currId - 1)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // top left
            if(currRow - 1 >= 0 && currCol - 1 >= 0) {
                let neighborId = currId - (max + 1)
                aStarRep(node: neighborId, parent: currId, goal: endNode)
            }

        }
        
    }
    
    func astar() {
        // Add Root element
        openList.append(startNode)
        status = "Searching ..."
        statusColor = Color.yellow
        gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(aStarUtil), userInfo: nil, repeats: true)
    }
    
    //MARK:- Dijkstra Search
    func dijkstraRep(node: Int, parent: Int, goal: Int) {
        
        let row = getRow(currId: node)
        let col = getColumn(currId: node)
        let goalRow = getRow(currId: goal)
        let goalCol = getColumn(currId: goal)
        
        // if not reachable or in closed list
        if walls[row][col] >= 1 || closedList.contains(node) {
            return
        }
        
        // if not in openlist
        if !openList.contains(node) {
            openList.append(node) // add to openlist
            parents[node] = parent // set currents parent
            g[node] = g[parent] + 1
//            let xDiff = Int(abs(row - goalRow))
//            let yDiff = Int(abs(col - goalCol))
//            h[node] = xDiff > yDiff ? xDiff : yDiff
//            f[node] = g[node] + h[node]
        }
        else {
            let gNewVal = g[parent] + 1
            
            if gNewVal < g[node] {
                parents[node] = parent
                g[node] = g[parent] + 1
//                let xDiff = Int(abs(row - goalRow))
//                let yDiff = Int(abs(col - goalCol))
//                h[node] = xDiff > yDiff ? xDiff : yDiff
//                f[node] = g[node] + h[node]
            }
        }
        
    }
    
    @objc func dijkstraUtil() {
        
        if openList.isEmpty || closedList.contains(endNode) {
            
            stopTimer()
            tracePath(node: endNode)
            
            return
            
        } else {
            
            // Sort openList by minimum f value
            openList.sort {
                g[$0] < g[$1]
            }
            
            // get current node
            let currId = openList[0]
            openList.removeFirst()

            // Append it to closedList
            closedList.append(currId)
            
            let currRow = getRow(currId: currId)
            let currCol = getColumn(currId: currId)
            
            visited[currRow][currCol] = 1
            visitedCount += 1
                            
            currentNode = currId
            row = currRow
            col = currCol

            // top
            if(currRow - 1 >= 0) {
                let neighborId = currId - max
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // top-right
            if(currRow - 1 >= 0 && currCol + 1 < max) {
                let neighborId = currId - (max-1)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // right
            if(currCol + 1 < max) {
                let neighborId = (currId + 1)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // bottom right
            if(currCol + 1 < max && currRow + 1 < max) {
                let neighborId = (currId + max + 1)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // bottom
            if(currRow + 1 < max) {
                let neighborId = (currId + max)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // bottom left
            if(currRow + 1 < max && currCol - 1 >= 0) {
                let neighborId = (currId + max - 1)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // left
            if(currCol - 1 >= 0) {
                let neighborId = (currId - 1)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }
            
            // top left
            if(currRow - 1 >= 0 && currCol - 1 >= 0) {
                let neighborId = currId - (max + 1)
                dijkstraRep(node: neighborId, parent: currId, goal: endNode)
            }

        }
    }
    
    func dijkstra() {
        // Add Root element
        openList.append(startNode)
        status = "Searching ..."
        statusColor = Color.yellow
        gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(dijkstraUtil), userInfo: nil, repeats: true)
    }

    //MARK:- BFS
    func bfsRep(neighborId: Int, currId: Int) {
        // If reached destination, stop
        if(neighborId == endNode) {
            stopTimer()
            tracePath(node: currId)
            return
        }
        
        let row = getRow(currId: neighborId)
        let col = (neighborId % max == 0) ? max-1 : (neighborId % max - 1)
        if(visited[row][col] == 0 && walls[row][col] == 0) {
            queue.append(neighborId)
            visited[row][col] = 1
            parents[neighborId] = currId
            visitedCount += 1
        }
    }
    
    @objc func bfsUtil() {
                
        if(!queue.isEmpty) {
            let currId = queue.removeFirst()
            let currRow = getRow(currId: currId)
            let currCol = getColumn(currId: currId)
            
            if walls[currRow][currCol] == 0 { // not wall
                
                currentNode = currId
                row = currRow
                col = currCol
                
                // Mark visited
                if(visited[currRow][currCol] == 0) {
                    visited[currRow][currCol] = 1
                    visitedCount += 1
                }
                
                // If reached destination, stop
                if(currId == endNode) {
                    stopTimer()
                    tracePath(node: currId)
                }

                // up
                if(currRow - 1 >= 0) {
                    let neighborId = currId - max
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // top-right
                if(currRow - 1 >= 0 && currCol + 1 < max) {
                    let neighborId = currId - (max-1)
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // right
                if(currCol + 1 < max) {
                    let neighborId = (currId + 1)
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // bottom right
                if(currCol + 1 < max && currRow + 1 < max) {
                    let neighborId = (currId + max + 1)
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // down
                if(currRow + 1 < max) {
                    let neighborId = (currId + max)
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // bottom left
                if(currRow + 1 < max && currCol - 1 >= 0) {
                    let neighborId = (currId + max - 1)
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // left
                if(currCol - 1 >= 0) {
                    let neighborId = (currId - 1)
                    bfsRep(neighborId: neighborId, currId: currId)
                }
                
                // top left
                if(currRow - 1 >= 0 && currCol - 1 >= 0) {
                    let neighborId = currId - (max + 1)
                    bfsRep(neighborId: neighborId, currId: currId)
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
    func dfsRep(neighborId: Int, currId: Int) {
        // If reached destination, stop
        if(neighborId == endNode) {
            stopTimer()
            tracePath(node: currId)
            return
        }
        
        let row = getRow(currId: neighborId)
        let col = getColumn(currId: neighborId)
        if(visited[row][col] == 0 && walls[row][col] == 0) {
            stack.append(neighborId)
            visited[row][col] = 1
            parents[neighborId] = currId
            visitedCount += 1
        }
    }
    
    @objc func dfsUtil() {
                
        if(!stack.isEmpty) {
            let currId = stack.popLast()!
            currentNode = currId
            let currRow = getRow(currId: currId)
            let currCol = getColumn(currId: currId)
            row = currRow
            col = currCol
            
            // Mark visited
            if(visited[currRow][currCol] == 0) {
                visited[currRow][currCol] = 1
                visitedCount += 1
            }
            
            // If reached destination, stop
            if(currId == endNode) {
                stopTimer()
                tracePath(node: currId)
            }

            // up
            if(currRow - 1 >= 0) {
                let neighborId = currId - max
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // top-right
            if(currRow - 1 >= 0 && currCol + 1 < max) {
                let neighborId = currId - (max-1)
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // right
            if(currCol + 1 < max) {
                let neighborId = (currId + 1)
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // bottom right
            if(currCol + 1 < max && currRow + 1 < max) {
                let neighborId = (currId + max + 1)
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // down
            if(currRow + 1 < max) {
                let neighborId = (currId + max)
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // bottom left
            if(currRow + 1 < max && currCol - 1 >= 0) {
                let neighborId = (currId + max - 1)
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // left
            if(currCol - 1 >= 0) {
                let neighborId = (currId - 1)
                dfsRep(neighborId: neighborId, currId: currId)
            }
            
            // top left
            if(currRow - 1 >= 0 && currCol - 1 >= 0) {
                let neighborId = currId - (max + 1)
                dfsRep(neighborId: neighborId, currId: currId)
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
