//
//  ViewController.swift
//  SocialPhotos
//
//  Created by Cornelius Hairston on 11/18/17.
//  Copyright © 2017 cornelius. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let plane = SCNNode()
        plane.geometry = SCNPlane(width: 0.4, height: 0.4)
        plane.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "socialphoto")
        plane.position = SCNVector3(0,0,-0.2)
        self.sceneView.scene.rootNode.addChildNode(plane)
    }
    
    func createPhoto(planeArchor: ARPlaneAnchor) -> SCNNode {
        let photoNode = SCNNode(geometry: SCNPlane(width: CGFloat(planeArchor.extent.x), height: CGFloat(planeArchor.extent.z) ))
        photoNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "socialphoto")
        photoNode.geometry?.firstMaterial?.isDoubleSided = true
        photoNode.position = SCNVector3(planeArchor.center.x,planeArchor.center.y,planeArchor.center.z)
        photoNode.eulerAngles = SCNVector3(90.degreeToRadians, 0, 0)
        return photoNode
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeArchor = anchor as? ARPlaneAnchor else {return}
        let photoNode = createPhoto(planeArchor: planeArchor)
        node.addChildNode(photoNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeArchor = anchor as? ARPlaneAnchor else {return}
        print("new plane")
    }


}


extension Int {
    var degreeToRadians: Double {return Double(self) * .pi/180}
}
