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
           
        ZStack {
            
            // Background
            Color(UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                Image("pattern1-1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            // Content
            VStack {
                Spacer()
                IntroView()
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
    
    // Empty constructor - Required to avoid crash
    public init() {
        //
    }
}

