//
//  PlaneNode.swift
//  ARapp
//
//  Created by masanobu.ban on 2020/01/04.
//  Copyright © 2020 masanobu.ban. All rights reserved.
//

import SceneKit
import ARKit

class PlaneNode: SCNNode {
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        plane.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        plane.widthSegmentCount = 10
        plane.heightSegmentCount = 10
        geometry = plane
        transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }
    
    func update(anchor: ARPlaneAnchor) {
        let plane = geometry as! SCNPlane
        plane.width = CGFloat(anchor.extent.x)
        plane.height = CGFloat(anchor.extent.z)
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
    }
}
