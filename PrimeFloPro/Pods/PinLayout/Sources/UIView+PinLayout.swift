//
//  UIView+PinLayout.swift
//  PinLayout
//
//  Created by Luc Dion on 2018-04-13.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

public extension UIView {
    public var pin: PinLayout {
        return PinLayoutImpl(view: self, keepTransform: true)
    }

    public var pinFrame: PinLayout {
        return PinLayoutImpl(view: self, keepTransform: false)
    }

    @objc public var anchor: AnchorList {
        return AnchorListImpl(view: self)
    }

    @objc public var edge: EdgeList {
        return EdgeListImpl(view: self)
    }

    // Expose PinLayout's objective-c interface.
    @objc public var pinObjc: PinLayoutObjC {
        return PinLayoutObjCImpl(view: self, keepTransform: true)
    }
}
#endif
