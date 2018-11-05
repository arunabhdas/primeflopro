//
//  NSView+PinLayout.swift
//  PinLayout
//
//  Created by Luc Dion on 2018-04-13.
//  Copyright © 2018 mcswiftlayyout.mirego.com. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit

public extension NSView {
    public var pin: PinLayout {
        return PinLayoutImpl(view: self, keepTransform: true)
    }

    public var pinFrame: PinLayout {
        return PinLayoutImpl(view: self, keepTransform: false)
    }

    public var anchor: AnchorList {
        return AnchorListImpl(view: self)
    }

    public var edge: EdgeList {
        return EdgeListImpl(view: self)
    }

    // Expose PinLayout's objective-c interface.
    @objc public var pinObjc: PinLayoutObjC {
        return PinLayoutObjCImpl(view: self, keepTransform: true)
    }
}

#endif
