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
    @Published var forks = [1, 1, 1, 1]
    @Published var occupants = [-1, -1, -1, -1] // -1 = empty
    @Published var blockedQueue = [Int]()
    
    var currentPlayer: Int?
    
    func stopPickTimer() {
        pickTimer?.invalidate()
    }
    
    @objc func pickLeft() {
        if let player = currentPlayer {
            forks[(player + 1) % 4] = 0
            occupants[(player + 1) % 4] = player
        }
    }
    
    func pickRight(player: Int) {
        forks[player] = 0
        occupants[player] = player
        currentPlayer = player
        pickTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(pickLeft), userInfo: nil, repeats: false)
    }
    
    @objc func putLeft(player: Int) {
        
    }
    
    func putRight(player: Int) {
        
    }
    
    func start(player: Int) {
        
        //forks = [1, 1, 1, 1]
        pickRight(player: player)
    }
    
    
    
}
