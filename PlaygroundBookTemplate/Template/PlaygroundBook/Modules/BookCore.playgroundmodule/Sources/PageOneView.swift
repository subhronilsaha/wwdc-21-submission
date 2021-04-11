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
    
    // SPRITEKIT SCENE
    public var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 512, height: 768)
        scene.scaleMode = .fill
        return scene
    }

    // BODY
    public var body: some View {
        
        ZStack {
            
            if #available(iOS 14.0, *) {
                SpriteView(scene: scene)
                    .frame(width: 512, height: 768)
                    .ignoresSafeArea()
            } else {
                // Fallback on earlier versions
            }
            
            VStack {
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.blue)
                        .frame(width: 120, height: 120)
                    Image("memoji-dev-guy")
                }
                
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
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "piano-bg-music", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            self.audioPlayer.play()
        }
        
    }
    
//    public var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
    
    public init() {
        //
    }
}

// A simple game scene with falling boxes
class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
}

// A sample SwiftUI creating a GameScene and sizing it
// at 300x400 points

