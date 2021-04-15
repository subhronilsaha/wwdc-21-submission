//
//  PageThreeView.swift
//  BookCore
//
//  Created by Subhronil Saha on 15/04/21.
//

import Foundation
import SwiftUI
import AVKit

//MARK:- Page Three Content View
public struct PageThreeView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    
    // constructor - NOTE: Required to avoid crash
    public init() {
         
    }
    
    // BODY
    public var body: some View {
            
        ZStack {
            // Background
//            Color.white
//                .edgesIgnoringSafeArea(.all)
            
            // Content
            VStack {
                Spacer()
                GameView().environmentObject(DiningGame())
                Spacer()
                Footer(audioPlayer: $audioPlayer)
                
            }
            .onAppear {
                let sound = Bundle.main.path(forResource: "piano-bg-music", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//                self.audioPlayer.play()
            }
        }
        
    }
}
