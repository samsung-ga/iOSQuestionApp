//
//  SwiftScene.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/06.
//

import UIKit
import SpriteKit
import CoreMotion

class SwiftScene: SKScene {
    
    private let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func addImageNode() {
        let swiftImage = SKSpriteNode(imageNamed: "swiftLogo")
        swiftImage.position = CGPoint(x: frame.midX, y: frame.midY)
        swiftImage.size = CGSize(width: 50, height: 45)
        self.addChild(swiftImage)
        
        swiftImage.physicsBody = SKPhysicsBody(circleOfRadius: swiftImage.size.width / 2)
        swiftImage.physicsBody?.allowsRotation = true
        swiftImage.physicsBody?.restitution = 0.5
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 12, dy: accelerometerData.acceleration.y * 12)
        }
    }
}
