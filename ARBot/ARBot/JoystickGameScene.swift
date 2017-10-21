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
    let moveAnalogStick = AnalogJoystick(diameter: 110)
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        moveAnalogStick.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        moveAnalogStick.stick.color = .red
        addChild(moveAnalogStick)
        
        moveAnalogStick.trackingHandler =   { joystickData in
            print("Angle : \(joystickData.angular)")
            print("Velocity : \(joystickData.velocity)\n")
        }
    }
}
