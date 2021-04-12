//
//  PageOneView.swift
//  BookCore
//
//  Created by Subhronil Saha on 12/04/21.
//

import SwiftUI
import SpriteKit
import AVKit

//MARK:- Page One Content View
public struct PageOneView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State var animate = false
    
    // BODY
    public var body: some View {
            
        VStack {
            Spacer()
            
            Image("memoji-dev-guy")
                .frame(width: 150, height: 150)
                .animation(.easeInOut, value: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
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
        .onAppear {
            let sound = Bundle.main.path(forResource: "dream-music", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
    }
    
    // Empty constructor - Required to avoid crash
    public init() {
        //
    }
}

