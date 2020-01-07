//
//  PhysicPlaneNode.swift
//  ARapp
//
//  Created by masanobu.ban on 2020/01/04.
//  Copyright © 2020 masanobu.ban. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class PhysicPlaneNode: SCNNode {
    
    required init?(coder: NSCoder) {
        fatalError("not implemeted!!")
    }
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        let planeHight: Float = 0.01
        let plane = SCNBox(width: CGFloat(anchor.extent.x), height: CGFloat(planeHight), length: CGFloat(anchor.extent.z), chamferRadius: 0.0)
        plane.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        plane.widthSegmentCount = 10
        plane.heightSegmentCount = 1
        plane.lengthSegmentCount = 10
        geometry = plane
        position = SCNVector3Make(anchor.center.x, -planeHight, anchor.center.z)
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody = SCNPhysicsBody(type: .static, shape: bodyShape)
        physicsBody?.friction = 3.0
        physicsBody?.restitution = 0.2
        physicsBody?.categoryBitMask = Category.planeCategory
        physicsBody?.collisionBitMask = Category.all  ^ Category.planeCategory
    }
    
    func update(anchor: ARPlaneAnchor) {
        let plane = geometry as! SCNBox
        plane.width = CGFloat(anchor.extent.x)
        plane.length = CGFloat(anchor.extent.z)
        let bodyShape = SCNPhysicsShape(geometry: geometry!, options: [:])
        physicsBody?.physicsShape = bodyShape
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
    }
}
