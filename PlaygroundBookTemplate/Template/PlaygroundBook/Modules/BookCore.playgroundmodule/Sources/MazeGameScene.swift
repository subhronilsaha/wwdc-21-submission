//
//  MazeGameScene.swift
//  BookCore
//
//  Created by Subhronil Saha on 12/04/21.
//

import SpriteKit
import PlaygroundSupport
import AVKit

public class MazeGameScene: SKScene {

    public override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
}
