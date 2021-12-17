//
//  Knob+Touches.swift
//  Acid Me!
//
//  Created by Matthew Fecher on 9/19/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//  Source: 3D Image Knob Example @ https://github.com/analogcode/3D-Knobs
//
//  Edited by Pedro M. Moreno on 26/12/2020.
//  ELE00083M iOS Programming for Audio.
//

import UIKit

///
/// extension Knob handles the user interaction events.
///
/// - author: Matthew Fecher
/// - Date: 9/19/2017.
///
extension Knob {

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint = touch.location(in: self)
            lastX = touchPoint.x
            lastY = touchPoint.y
        }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPoint = touch.location(in: self)
            setPercentagesWithTouchPoint(touchPoint)
        }
    }

}
