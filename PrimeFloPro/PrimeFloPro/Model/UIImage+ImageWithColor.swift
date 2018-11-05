//
//  UIImage+ImageWithColor.swift
//  PrimeFloPro
//
//  Created by Das on 6/3/18.
//  Copyright © 2018 arunabhdas. All rights reserved.
//

import UIKit

extension UIImage {
	static func imageWithColor(tintColor: UIColor) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
		tintColor.setFill()
		UIRectFill(rect)
		let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}
}
