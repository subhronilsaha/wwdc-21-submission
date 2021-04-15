//
//  PageOneView.swift
//  BookCore
//
//  Created by Subhronil Saha on 12/04/21.
//

import SwiftUI
import SpriteKit
import AVKit

//MARK:- Page Two Content View
public struct PageTwoView: View {
    
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
                MazeView().environmentObject(Maze())
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

//MARK:- Footer
public struct Footer: View {
    
    @Binding var audioPlayer: AVAudioPlayer!
    
    public var body: some View {
        HStack {
            Spacer()
            Text("Play/Pause Music ")
            Button(action: {
                self.audioPlayer.play()
            }) {
                Image(systemName: "play.circle.fill").resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
            }
            Button(action: {
                self.audioPlayer.pause()
            }) {
                Image(systemName: "pause.circle.fill").resizable()
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
            }
        }.padding(10)
    }
    
}
