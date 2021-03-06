//
//  SecondViewController.swift
//  PrimeFloPro
//

import UIKit
import SceneKit
import ARKit

class NextSecondViewController: UIViewController, ARSCNViewDelegate {
	@IBOutlet weak var sceneView: ARSCNView!
	@IBOutlet weak var addHoopButton: UIButton!
	var currentNode: SCNNode!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		// Set the view's delegate
		self.sceneView.delegate = self
		
		// Show statistics such as fps and timing information
		// self.sceneView.showsStatistics = true
	
		
		// addBackboard()
		registerGestureRecognizer()
    }

	func addBackboard() {
		guard let backboardScene = SCNScene(named: "art.scnassets/hoop.scn") else {
			return
		}
		
		guard let backboardNode = backboardScene.rootNode.childNode(withName: "backboard", recursively: false) else {
			return
		}
		
		backboardNode.position = SCNVector3(x: 0, y: -2.0, z: -3.0)
		let physicsShape = SCNPhysicsShape(node: backboardNode, options: [SCNPhysicsShape.Option.type: SCNPhysicsShape.ShapeType.concavePolyhedron])
		let physicsBody = SCNPhysicsBody(type: .static, shape: physicsShape)
		backboardNode.physicsBody = physicsBody
		
		self.sceneView.scene.rootNode.addChildNode(backboardNode)
		self.currentNode = backboardNode
		
	
	}
	func horizontalAction(node: SCNNode) {
		let leftAction = SCNAction.move(by: SCNVector3(x: -1, y: 0, z: 0), duration: 3)
		let rightAction = SCNAction.move(by: SCNVector3(x: 1, y: 0, z: 0), duration: 3)
		
		let actionSequence = SCNAction.sequence([leftAction, rightAction])
		
		node.runAction(SCNAction.repeat(actionSequence, count: 2))
	}
	
	// /\
	// \/
	func roundAction(node: SCNNode) {
		let upLeft = SCNAction.move(by: SCNVector3(x: 1, y: 1, z: 0), duration: 2)
		let downRight = SCNAction.move(by: SCNVector3(x: 1, y: -1, z: 0), duration: 2)
		let downLeft = SCNAction.move(by: SCNVector3(x: -1, y: -1, z: 0), duration: 2)
		let upRight = SCNAction.move(by: SCNVector3(x: -1, y: 1, z: 0), duration: 2)
		
		let actionSequence = SCNAction.sequence([upLeft, downRight, downLeft, upRight])
		node.runAction(SCNAction.repeat(actionSequence, count: 2))
		
		
		
	}
	@IBAction func startRoundAction(_ sender: Any) {
		roundAction(node: currentNode)
	}
	
	@IBAction func stopAllActions(_ sender: Any) {
		currentNode.removeAllActions()
	}
	
	@IBAction func startHorizontalAction(_ sender: Any) {
		horizontalAction(node: currentNode)
	}
	@IBAction func addHoop(_ sender: Any) {
		addBackboard()
		self.addHoopButton.isHidden = true
	}
	
	func registerGestureRecognizer() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		sceneView.addGestureRecognizer(tap)
		
	}
	@objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
		// scene view to be accessed
		guard let scnView = gestureRecognizer.view as? ARSCNView else {
			return
		}
		
		guard let centerPoint = scnView.pointOfView else {
			return
		}
		// transform matrix
		// the orientation
		// the location of the camera
		// orientation and location to determine the position of the camera and it's at this point in which we want the ball to be placed
		
		// access the point of view of the scene view ... the center point
		let cameraTransform = centerPoint.transform
		let cameraLocation = SCNVector3(x: cameraTransform.m41, y: cameraTransform.m42, z: cameraTransform.m43)
		let cameraOrientation = SCNVector3(x: -cameraTransform.m31, y: -cameraTransform.m32, z: -cameraTransform.m33)
		
		let cameraPosition = SCNVector3Make(cameraLocation.x + cameraOrientation.x, cameraLocation.y + cameraOrientation.y, cameraLocation.z + cameraOrientation.z)
		
		let ball = SCNSphere(radius: 0.15)
		let material = SCNMaterial()
		material.diffuse.contents = UIImage(named: "basketballSkin")
		ball.materials = [material]
		
		let ballNode = SCNNode(geometry: ball)
		ballNode.position = cameraPosition
		sceneView.scene.rootNode.addChildNode(ballNode)
		
		let physicsShape = SCNPhysicsShape(node: ballNode, options: nil)
		let physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
		
		ballNode.physicsBody = physicsBody
		let forceVector: Float = 6
		ballNode.physicsBody?.applyForce(SCNVector3(x: cameraPosition.x * forceVector, y: cameraPosition.y  * forceVector, z: cameraPosition.z * forceVector), asImpulse: true)
		

		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARWorldTrackingConfiguration()
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
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

}
