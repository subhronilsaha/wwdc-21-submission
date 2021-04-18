//
//  DiningGame.swift
//  BookCore
//
//  Created by Subhronil Saha on 15/04/21.
//

import Foundation
import SwiftUI

class DiningGame: ObservableObject {
     
    // Constructor
    public init() {
        
    }
    
    var pickTimer: Timer?
    let imageNames = ["boy2", "girl2", "girl", "boy"]
    @Published var status = ["thinking", "thinking", "thinking", "thinking"]
    @Published var statusColor = [Color.yellow, Color.yellow, Color.yellow, Color.yellow,]
    @Published var forks = [1, 1, 1, 1] // 1 = available, 0 = blocked
    @Published var occupants = [-1, -1, -1, -1] // -1 = empty, 0...3 = occupant id
    @Published var blockedQueue = [Int]()
    var mode = 0 // 0 = normal, 1 = deadlock prevent
    
    var currentPlayer: Int?
    
//    func stopPickTimer() {
//        pickTimer?.invalidate()
//    }
    
    // NORMAL Code
    func changeStatus(player: Int) {
        if status[player] == "thinking" {
            if forks[player] == 1 {
                // update status
                forks[player] = 0
                occupants[player] = player
                status[player] = "took right fork"
                statusColor[player] = Color.pink
                
                // if player was previously blocked, remove block
                if blockedQueue.contains(player) {
                    let index = blockedQueue.firstIndex(of: player)!
                    blockedQueue.remove(at: Int(index))
                }
                
            } else {
                // block player
                if !blockedQueue.contains(player) {
                    blockedQueue.append(player)
                }
            }
            
        } else if status[player] == "took right fork" {
            if forks[(player+1)%4] == 1 {
                // update status
                status[player] = "took left fork"
                statusColor[player] = Color.pink
                forks[(player+1)%4] = 0
                occupants[(player+1)%4] = player
                
                // if player was previously blocked, remove block
                if blockedQueue.contains(player) {
                    let index = blockedQueue.firstIndex(of: player)!
                    blockedQueue.remove(at: Int(index))
                }
                
            } else {
                // block player
                if !blockedQueue.contains(player) {
                    blockedQueue.append(player)
                }
            }
            
        } else if status[player] == "took left fork" {
            // update status
            status[player] = "eating"
            statusColor[player] = Color.green
            
        } else if status[player] == "eating" {
            // update status
            status[player] = "put right fork"
            statusColor[player] = Color.pink
            forks[player] = 1
            occupants[player] = -1
            
        } else if status[player] == "put right fork" {
            // update status
            status[player] = "put left fork"
            statusColor[player] = Color.pink
            forks[(player+1)%4] = 1
            occupants[(player+1)%4] = -1
            
        } else if status[player] == "put left fork" {
            // update status back to thinking
            status[player] = "thinking"
            statusColor[player] = Color.yellow
            
        }
    }
    
    // DEADLOCK PREVENT CODE FOR Player 3
    func deadlockChangeStatus(player: Int) {
        if status[player] == "thinking" {
            if forks[(player+1)%4] == 1 {
                // update status
                status[player] = "took left fork"
                statusColor[player] = Color.pink
                forks[(player+1)%4] = 0
                occupants[(player+1)%4] = player
                
                // if player was previously blocked, remove block
                if blockedQueue.contains(player) {
                    let index = blockedQueue.firstIndex(of: player)!
                    blockedQueue.remove(at: Int(index))
                }
                
            } else {
                // block player
                if !blockedQueue.contains(player) {
                    blockedQueue.append(player)
                }
            }
            
        } else if status[player] == "took left fork" {
            if forks[player] == 1 {
                // update status
                forks[player] = 0
                occupants[player] = player
                status[player] = "took right fork"
                statusColor[player] = Color.pink
                
                // if player was previously blocked, remove block
                if blockedQueue.contains(player) {
                    let index = blockedQueue.firstIndex(of: player)!
                    blockedQueue.remove(at: Int(index))
                }
                
            } else {
                // block player
                if !blockedQueue.contains(player) {
                    blockedQueue.append(player)
                }
            }
            
        } else if status[player] == "took right fork" {
            // update status
            status[player] = "eating"
            statusColor[player] = Color.green
            
        } else if status[player] == "eating" {
            // update status
            status[player] = "put left fork"
            statusColor[player] = Color.pink
            forks[(player+1)%4] = 1
            occupants[(player+1)%4] = -1
            
        } else if status[player] == "put left fork" {
            
            // update status
            status[player] = "put right fork"
            statusColor[player] = Color.pink
            forks[player] = 1
            occupants[player] = -1
            
        } else if status[player] == "put right fork" {
            // update status back to thinking
            status[player] = "thinking"
            statusColor[player] = Color.yellow
            
        }
    }
    
    func start(player: Int) {
        if mode == 1 && player == 3 {
            deadlockChangeStatus(player: 3)
        } else {
            changeStatus(player: player)
        }
    }
    
    func preventDeadlock() {
        mode = 1
        reset()
    }
    
    func reset() {
        status = ["thinking", "thinking", "thinking", "thinking"]
        statusColor = [Color.yellow, Color.yellow, Color.yellow, Color.yellow,]
        forks = [1, 1, 1, 1] // 1 = available, 0 = blocked
        occupants = [-1, -1, -1, -1] // -1 = empty, 0...3 = occupant id
        blockedQueue = [Int]()
    }
    
}

