//
//  ItemList.swift
//  PrimeFloPro
//
//  Created by Das on 6/3/18.
//  Copyright © 2018 arunabhdas. All rights reserved.
//

import Foundation
import SceneKit

class ItemList {
	
	func addChair() -> SCNNode {
		let node = SCNNode()
		let scene = SCNScene(named: "art.scnassets/chair.scn")!
		let nodeArray = scene.rootNode.childNodes
		
		for childNode in nodeArray {
			node.addChildNode(childNode as SCNNode)
		}
		return node
	}
	
	func addCup() -> SCNNode {
		let node = SCNNode()
		let scene = SCNScene(named: "art.scnassets/cup.scn")!
		let nodeArray = scene.rootNode.childNodes
		
		for childNode in nodeArray {
			node.addChildNode(childNode as SCNNode)
		}
		return node
	}
	
	func addLamp() -> SCNNode {
		let node = SCNNode()
		let scene = SCNScene(named: "art.scnassets/lamp.scn")!
		let lamp = scene.rootNode.childNode(withName: "lamp", recursively: true)
		let nodeArray = scene.rootNode.childNodes
		
		for childNode in nodeArray {
			node.addChildNode(childNode as SCNNode)
		}
		//return node
		return lamp!
	}
	
	func addTable() -> SCNNode {
		let node = SCNNode()
		let scene = SCNScene(named: "art.scnassets/table.scn")!
		let table = scene.rootNode.childNode(withName: "table", recursively: true)
		let nodeArray = scene.rootNode.childNodes
		
		for childNode in nodeArray {
			node.addChildNode(childNode as SCNNode)
		}
		// return node
		return table!
	}
	
	func addVase() -> SCNNode {
		let node = SCNNode()
		let scene = SCNScene(named: "art.scnassets/flower.scn")!
		let nodeArray = scene.rootNode.childNodes
		
		for childNode in nodeArray {
			node.addChildNode(childNode as SCNNode)
		}
		return node
	}
}
