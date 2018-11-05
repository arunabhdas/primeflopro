//
//  ThirdViewController.swift
//  PrimeFloPro
//

import UIKit
import SceneKit
import ARKit

class NextThirdViewController: UIViewController, ARSCNViewDelegate  {

	@IBOutlet weak var sceneView: ARSCNView!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		sceneView.delegate = self
		// sceneView.showsStatistics = false
		sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
		
		// let scene = SCNScene(named: "art.scnassets/ship.scn")!
		
		// sceneView.scene = scene
		self.sceneView.showsStatistics = true
		registerGestureRecognizer()
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
	
	func registerGestureRecognizer() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		sceneView.addGestureRecognizer(tap)
	}

	@objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
		let touchLocation = gestureRecognizer.location(in: sceneView)
		let hitResult = self.sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
		
		if (hitResult.count > 0) {
			
			guard let hitTestResult = hitResult.first else {
				return
			}
			
			let ball = SCNSphere(radius: 0.1)
			let material = SCNMaterial()
			material.diffuse.contents = Constants.Colors.nicheMidnightBlue
			ball.materials = [material]
			
			let ballNode = SCNNode(geometry: ball)
			let worldPos = hitTestResult.worldTransform
			
			ballNode.position = SCNVector3(x: worldPos.columns.3.x, y: worldPos.columns.3.y, z: worldPos.columns.3.z)
			sceneView.scene.rootNode.addChildNode(ballNode)
			
			
			
			
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
