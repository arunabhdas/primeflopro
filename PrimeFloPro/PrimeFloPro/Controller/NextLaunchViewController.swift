//
//  NextLaunchViewController.swift
//  PrimeFloPro
//
//  Created by Das on 6/3/18.
//  Copyright © 2018 arunabhdas. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class NextLaunchViewController: UIViewController, ARSCNViewDelegate {
	@IBOutlet var sceneView: ARSCNView!
	var chosenNode: SCNNode?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		sceneView.delegate = self
		
		sceneView.showsStatistics = false
		// sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]

		registerGestureRecognizer()
    }
	func registerGestureRecognizer() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		tap.numberOfTapsRequired = 1
		
		
		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
		doubleTap.numberOfTapsRequired = 2
		
		tap.require(toFail: doubleTap)
		
		sceneView.addGestureRecognizer(tap)
		sceneView.addGestureRecognizer(doubleTap)
	}
	

	@objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
		guard let vehicle = chosenNode else {
			return
		}
		switch vehicle.name {
		case "ufo":
			return ufoAction()
		case "shuttle":
			return shuttleAction()
		default:
			return ufoAction()
			
		}
	}
	@objc func handleDoubleTap(gestureRecognizer: UIGestureRecognizer) {
		guard let name = chosenNode?.name else {
			return
		}
		if (name == "ufo") {
			launchUfo()
		} else {
			return
		}
		
	}
	func shuttleAction() {
		guard let node = chosenNode else {
			return
		}
		let upAction = SCNAction.move(by: SCNVector3(0, 100, 0.05), duration: 100)
		node.runAction(SCNAction.repeatForever(upAction))
	}
	
	func ufoAction() {
		guard let node = chosenNode else {
			return
		}
		let leftAction = SCNAction.move(by: SCNVector3(-1, 0, 0), duration: 1)
		
		let rightAction = SCNAction.move(by: SCNVector3(1, 0, 0), duration: 1)
		
		leftAction.timingMode = SCNActionTimingMode.easeInEaseOut
		
		rightAction.timingMode = SCNActionTimingMode.easeInEaseOut
		
		let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(0.2), z: 0, duration: 0.1)
		
		node.runAction(SCNAction.repeatForever(SCNAction.sequence([leftAction, rightAction])))
		
		node.runAction(SCNAction.repeatForever(rotate))
		
	}
	func launchUfo() {
		guard let node = chosenNode else {
			return
		}
		let upAction = SCNAction.move(by: SCNVector3(0, 100, 0), duration: 100)
		node.runAction(SCNAction.repeatForever(upAction))
		
	}
	
	func addShuttle() {
		let scene = SCNScene(named: "art.scnassets/shuttle.scn")
		guard let fireNode = scene?.rootNode.childNode(withName: "fireNode", recursively: true),
		let shuttleNode = scene?.rootNode.childNode(withName: "shuttleNode", recursively: true)
		else {
			fatalError("Something is missing")
		
		}
		
		let fire = SCNParticleSystem(named: "fire.scnp", inDirectory: nil)
		
		fireNode.addParticleSystem(fire!)
		shuttleNode.addChildNode(fireNode)
		shuttleNode.scale = SCNVector3(0.05, 0.05, 0.05)
		shuttleNode.position = SCNVector3(x: 0, y: -0.5, z: -1.5)
		sceneView.scene.rootNode.addChildNode(shuttleNode)
		shuttleNode.name = "shuttle"
		chosenNode = shuttleNode
		
	}
	func addUfo() {
		let scene = SCNScene(named: "art.scnassets/ufo.scn")
		guard let ufoNode = scene?.rootNode.childNode(withName: "ufoNode", recursively: true) else {
			fatalError("Something is missing")
		}
		let stars = SCNParticleSystem(named: "stars.scnp", inDirectory: nil)
		
		let starNode = SCNNode()
		starNode.addParticleSystem(stars!)
		ufoNode.addChildNode(starNode)
		ufoNode.scale = SCNVector3(0.3, 0.3, 0.3)
		ufoNode.position = SCNVector3(x: 0, y: -0.5, z: -0.5)
		sceneView.scene.rootNode.addChildNode(ufoNode)
		ufoNode.name = "ufo"
		chosenNode = ufoNode
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARWorldTrackingConfiguration()
		configuration.planeDetection = .horizontal
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
	}
	
	@IBAction func shuttleButtonTapped(_ sender: Any) {
		addShuttle()
	}
	
	@IBAction func ufoButtonTapped(_ sender: Any) {
		addUfo()
	}
	@IBAction func deleteButtonTapped(_ sender: Any) {
		sceneView.scene.rootNode.enumerateChildNodes{ (node,stop) in
			node.removeFromParentNode()
		}
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
}
