//
//  JoystickGameScene.swift
//  ARBot
//
//  Created by Dhruv  Sringari on 10/12/17.
//  Copyright © 2017 Dhruv Sringari. All rights reserved.
//

import SpriteKit

class JoystickGameScene: SKScene {
    var dataDelegate: ARBotCommunicationDelegate!
    let leftAnalogStick = AnalogJoystick(diameter: 110)
    let rightAnalogStick = AnalogJoystick(diameter: 110)
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        leftAnalogStick.position = CGPoint(x: view.frame.midX, y: view.frame.maxY*(3/4))
        leftAnalogStick.stick.color = .red
        addChild(leftAnalogStick)
        
        rightAnalogStick.position = CGPoint(x: view.frame.midX, y: view.frame.midY/2)
        rightAnalogStick.stick.color = .red
        addChild(rightAnalogStick)
        
        
        leftAnalogStick.trackingHandler =   { joystickData in
            self.dataDelegate.update(speedLeft: self.map(joystickData.velocity.x), speedRight: -256)
        }
        
        rightAnalogStick.trackingHandler =   { joystickData in
            self.dataDelegate.update(speedLeft: -256, speedRight: self.map(joystickData.velocity.x))
        }
        
        leftAnalogStick.stopHandler = {
            self.dataDelegate.stop(left: true, right: false)
        }
        
        rightAnalogStick.stopHandler = {
            self.dataDelegate.stop(left: false, right: true)
        }
    }
    
    func map(_ x: CGFloat) -> Int {
        let mapped = x.map(from: -55...55, to: -255...255)
        return Int(mapped)
    }
}

extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
}
