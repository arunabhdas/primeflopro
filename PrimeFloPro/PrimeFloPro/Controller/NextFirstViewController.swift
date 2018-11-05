//
//  ViewController.swift
//  PrimeFloPro
//
//

import UIKit
import SceneKit
import ARKit

class NextFirstViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
	@IBOutlet weak var drawButton: UIButton!
	var currentColor = Constants.Colors.classyGreen
	var chosenNode = SCNNode()
	let myItems = ItemList()
	@IBOutlet weak var leftDeleteButton: UIButton!
	@IBOutlet weak var leftButton: UIButton!
	@IBOutlet weak var rightButton: UIButton!
	@IBOutlet weak var deleteButton: UIButton!
	@IBOutlet weak var chairButton: UIButton!
	@IBOutlet weak var tableButton: UIButton!
	@IBOutlet weak var vaseButton: UIButton!
	@IBOutlet weak var lampButton: UIButton!
	@IBOutlet weak var cupButton: UIButton!
	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.navigationBar.barTintColor = Constants.Colors.primaryColor
		self.navigationController?.navigationBar.isTranslucent = false
		view.backgroundColor = Constants.Colors.primaryColor
		
		// let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
		// backgroundImage.image = UIImage(named: Constants.AssetNames.kAssetBackground)
		// backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
		// self.view.insertSubview(backgroundImage, at: 0)
		
		
		title = Constants.TabTitles.kTitleFour

		// let rightImage = UIImage.fontAwesomeIcon(name: .sliders, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
		let rightImage = UIImage(named: Constants.AssetNames.kAssetSliders)
		let rightImageOriginal = rightImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		
		// navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImageOriginal, style: .plain, target: self, action: "signOutTapped")

        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
		// sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // sceneView.showsStatistics = true
		
		registerGestureRecognizer()
        
        // Create a new scene
        // let scene = SCNScene(named: "art.scnassets/ship.scn")!
		// let scene = SCNScene()
		
		/*
		let firstCube = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.05)
		let firstCubeMaterial = SCNMaterial()
		firstCubeMaterial.diffuse.contents = Constants.Colors.nicheDarkBlue
		firstCube.materials = [firstCubeMaterial]
		let firstCubeNode = SCNNode(geometry: firstCube)
		firstCubeNode.position = SCNVector3(x: 0, y: 0.2, z: -1.0)
		
		
		let rectangle = SCNBox(width: 0.2, height: 0.2, length: 0.4, chamferRadius: 0.0)
		let rectangleMaterial = SCNMaterial()
		rectangleMaterial.diffuse.contents = Constants.Colors.nicheLightBlue
		rectangle.materials = [rectangleMaterial]
		let rectangleNode = SCNNode(geometry: rectangle)
		rectangleNode.position = SCNVector3(x: 0, y: 0.5, z: -1.0)
		
		
		let firstText = SCNText(string: "Das", extrusionDepth: 1)
		let textMaterial = SCNMaterial()
		textMaterial.diffuse.contents = Constants.Colors.classyPurple
		firstText.materials = [textMaterial]
        let textNode = SCNNode(geometry: firstText)
		textNode.position = SCNVector3(x: 0.0, y: 0.0, z: -1.0)
		textNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
		
		scene.rootNode.addChildNode(firstCubeNode)
		scene.rootNode.addChildNode(rectangleNode)
		scene.rootNode.addChildNode(textNode)
		sceneView.scene = scene
		*/
        // Set the scene to the view
		
		
		
    }
	
	func registerGestureRecognizer() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		sceneView.addGestureRecognizer(tap)
	}
	
	@objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
		// let touchLocation = gestureRecognizer.location(in: sceneView)
		let sceneLocation = gestureRecognizer.view as? ARSCNView!
		let touchLocation = gestureRecognizer.location(in: sceneLocation!)
		
		let hitResult = self.sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent, .estimatedHorizontalPlane])
		
		if (hitResult.count > 0) {
			
			guard let hitTestResult = hitResult.first else {
				return
			}
			addItem(hitTestResult: hitTestResult)
			
		}
	}
	func addItem(hitTestResult: ARHitTestResult) {
		let itemNode = chosenNode
		let worldPos = hitTestResult.worldTransform
		
		itemNode.position = SCNVector3(x: worldPos.columns.3.x, y: worldPos.columns.3.y, z: worldPos.columns.3.z)
		sceneView.scene.rootNode.addChildNode(itemNode)
		
		// let scene = SCNScene(named: "art.scnassets/ship.scn")!
		// let scene = SCNScene(named: "art.scnassets/flower.scn")!
		// sceneView.scene = scene
	}


	func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
		guard let cameraPoint = sceneView.pointOfView else {
			return
		}
		
		let cameraTransform = cameraPoint.transform
		let cameraLocation = SCNVector3(x: cameraTransform.m41, y: cameraTransform.m42, z: cameraTransform.m43)
		
		let cameraOrientation = SCNVector3(x: -cameraTransform.m31, y: -cameraTransform.m32, z: -cameraTransform.m33)
		// x1 + x2, y1 + y2, z1 + z2
		let cameraPosition = SCNVector3Make(cameraLocation.x + cameraOrientation.x, cameraLocation.y + cameraLocation.y, cameraLocation.z + cameraOrientation.z)
		
		DispatchQueue.main.async {
			if (self.drawButton.isTouchInside) {
				let sphere = SCNSphere(radius: 0.02)
				let material = SCNMaterial()
				material.diffuse.contents = self.currentColor
				sphere.materials = [material]
				let sphereNode = SCNNode(geometry: sphere)
				sphereNode.position = SCNVector3(x: cameraPosition.x, y: cameraPosition.y, z: cameraPosition.z)
				self.sceneView.scene.rootNode.addChildNode(sphereNode)
			}
		}
		

		


		
		
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
	
	

	@IBAction func chairButtonTapped(_ sender: Any) {
		chosenNode = myItems.addChair()
		chairButton.setBackgroundImage(UIImage.imageWithColor(tintColor: Constants.Colors.nicheDarkBlue), for: .normal)
		tableButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		vaseButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		lampButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		cupButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)

		showButtons()
	}
	

	@IBAction func tableButtonTapped(_ sender: Any) {
		chosenNode = myItems.addTable()
		tableButton.setBackgroundImage(UIImage.imageWithColor(tintColor: Constants.Colors.nicheDarkBlue), for: .normal)
		chairButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		vaseButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		lampButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		cupButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		showButtons()
	}

	@IBAction func vaseButtonTapped(_ sender: Any) {
		chosenNode = myItems.addVase()
		tableButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		chairButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		vaseButton.setBackgroundImage(UIImage.imageWithColor(tintColor: Constants.Colors.nicheDarkBlue), for: .normal)
		
		lampButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		cupButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		showButtons()
	}

	@IBAction func lampButtonTapped(_ sender: Any) {
		chosenNode = myItems.addLamp()
		tableButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		chairButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		vaseButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		lampButton.setBackgroundImage(UIImage.imageWithColor(tintColor: Constants.Colors.nicheDarkBlue), for: .normal)
		cupButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		showButtons()
	}
	
	@IBAction func cupButtonTapped(_ sender: Any) {
		chosenNode = myItems.addCup()
		tableButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		chairButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		vaseButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		lampButton.setBackgroundImage(UIImage.imageWithColor(tintColor: UIColor.clear), for: .normal)
		cupButton.setBackgroundImage(UIImage.imageWithColor(tintColor: Constants.Colors.nicheDarkBlue), for: .normal)
		showButtons()
	}
	
	@IBAction func actualLeftRotate(_ sender: Any) {
		let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(0.09 * Double.pi), z: 0, duration: 0.1)
		chosenNode.runAction(rotate)
		// sceneView.scene.rootNode.addChildNode(chosenNode)
	}
	
	@IBAction func actualRightRotate(_ sender: Any) {
		let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(-0.09 * Double.pi), z: 0, duration: 0.1)
		chosenNode.runAction(rotate)
		sceneView.scene.rootNode.addChildNode(chosenNode)
	}
	
	@IBAction func leftDeleteButtonTapped(_ sender: Any) {
		sceneView.scene.rootNode.enumerateChildNodes{ (node,stop) in
				node.removeFromParentNode()
		}
	}
	
	@IBAction func deleteButtonTapped(_ sender: Any) {
		chosenNode.removeFromParentNode()
		
	}
	
	func showButtons() {
		leftButton.isHidden = false
		rightButton.isHidden = false
		leftDeleteButton.isHidden = false
		deleteButton.isHidden = false
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
