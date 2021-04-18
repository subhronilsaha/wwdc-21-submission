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
            Color(UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
                        
            // Content
            VStack {
                Spacer()
                MazeView().environmentObject(Maze())
                Spacer()
                Footer(audioPlayer: $audioPlayer)
                
            }
            .onAppear {
                let sound = Bundle.main.path(forResource: "fragile-lofi", ofType: "mp3")
                self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                self.audioPlayer.play()
            }
        }
        
    }
}

//MARK:- Footer
public struct Footer: View {
    
    @Binding var audioPlayer: AVAudioPlayer!
    let copyrightMusic: [String] = ["Fragile by Keys of Moon | https://soundcloud.com/keysofmoon", "Attribution 4.0 International (CC BY 4.0)", "https://creativecommons.org/licenses/by/4.0/", "Music promoted by https://www.chosic.com/"]
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Play/Pause Music ")
                    .foregroundColor(.white)
                
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
            
//            // Attribution
//            VStack {
//                ForEach(0..<self.copyrightMusic.count, id: \.self) { i in
//                    HStack {
//                        Spacer()
//                        Text(self.copyrightMusic[i]).font(.system(size: 5))
//                    }
//                }
//            }
        }
    }
    
}
