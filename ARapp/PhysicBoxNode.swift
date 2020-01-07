//
//  PhysicBoxNode.swift
//  ARapp
//
//  Created by masanobu.ban on 2020/01/04.
//  Copyright © 2020 masanobu.ban. All rights reserved.
//

import UIKit
import ARKit

class PhysicBoxNode: SCNNode {
    
    required init?(coder: NSCoder) {
        fatalError("not implemeted!!")
    }
    
    override init() {
        super.init()
        let box = SCNBox(width: 0.1, height: 0.05, length: 0.1, chamferRadius: 0.01)
        box.firstMaterial?.diffuse.contents = UIColor.gray
        geometry = box
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
        physicsBody?.friction = 2.0
        physicsBody?.restitution = 0.2
        physicsBody?.categoryBitMask = Category.boxCategory
        physicsBody?.collisionBitMask = Category.all
    }
}
