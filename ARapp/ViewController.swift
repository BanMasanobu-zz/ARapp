//
//  ViewController.swift
//  ARapp
//
//  Created by masanobu.ban on 2020/01/04.
//  Copyright © 2020 masanobu.ban. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var nodes: Array<SCNNode>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.scene = SCNScene()
        sceneView.debugOptions = [.showWireframe, .showPhysicsShapes]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    @IBAction func tapSceneView(_ sender: UITapGestureRecognizer) {
        let tapLoc = sender.location(in: sceneView)
        let results = sceneView.hitTest(tapLoc, types: .existingPlaneUsingExtent)
        guard let result = results.first else { return }
        if let anchor = result.anchor as? ARPlaneAnchor {
            if anchor.alignment == .vertical {
                return
            }
        }
        let boxNode = PhysicBoxNode()
        let earthNode = PhysicEarghNode()
        nodes = [boxNode, earthNode]
        let index = Int(arc4random())%(nodes.count)
        let node = nodes[index]
        let pos = result.worldTransform.columns.3
        let y = pos.y + 0.2
        node.position = SCNVector3(x: pos.x, y: y, z: pos.z)
        sceneView.scene.rootNode.addChildNode(node)
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        node.addChildNode(PhysicPlaneNode(anchor: planeAnchor))
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        guard let planeNode = node.childNodes.first as? PhysicPlaneNode else {
            return
        }
        planeNode.update(anchor: planeAnchor)
    }
}
