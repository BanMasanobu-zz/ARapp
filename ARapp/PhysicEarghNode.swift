//
//  PhysicEarghNode.swift
//  ARapp
//
//  Created by masanobu.ban on 2020/01/04.
//  Copyright © 2020 masanobu.ban. All rights reserved.
//

import UIKit
import ARKit

class PhysicEarghNode: SCNNode {
    
    required init?(coder: NSCoder) {
        fatalError("not implemeted!!")
    }
    
    override init() {
        super.init()
        let earth = SCNSphere(radius: 0.05)
        earth.firstMaterial?.diffuse.contents = UIImage(named: "rails")
        geometry = earth
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: bodyShape)
        physicsBody?.friction = 1.0
        physicsBody?.rollingFriction = 1.0
        physicsBody?.restitution = 0.5
        physicsBody?.categoryBitMask = Category.earthCategory
        physicsBody?.collisionBitMask = Category.all
    }
}
