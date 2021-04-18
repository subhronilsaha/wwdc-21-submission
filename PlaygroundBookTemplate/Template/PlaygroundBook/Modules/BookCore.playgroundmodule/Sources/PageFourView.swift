//
//  PageFourView.swift
//  BookCore
//
//  Created by Subhronil Saha on 17/04/21.
//

import Foundation
import SwiftUI
import AVKit

//MARK:- Page Three Content View
public struct PageFourView: View {
    
    @State var audioPlayer: AVAudioPlayer!

    // constructor - NOTE: Required to avoid crash
    public init() {
         
    }
    
    // BODY
    public var body: some View {
            
        ZStack {
            
            // Content
            VStack {
                Spacer()
                AboutMeView()
                Spacer()
                Footer(audioPlayer: $audioPlayer)
                
            }
            .onAppear {
                let sound = Bundle.main.path(forResource: "depth-music", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
            }
        }
        
    }
}
