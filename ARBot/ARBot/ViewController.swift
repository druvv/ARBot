//
//  ViewController.swift
//  ARBot
//
//  Created by Dhruv  Sringari on 9/27/17.
//  Copyright © 2017 Dhruv Sringari. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol ARBotCommunicationDelegate {
    func changeServoSpeed(speed: Int)
}

class ViewController: UIViewController {
    enum BluetoothStatus {
        case off
        case searching
        case connected
        case stopped
        case unknown
    }
    
    enum MoveTask {
        case forward
        case backward
        case rotateLeft
        case rotateRight
    }
    
    var serial: BluetoothSerial!
    @IBOutlet var bluetoothStatusLabel: UILabel!
    var bluetoothStatus: BluetoothStatus = .off
    @IBOutlet var motorSpeedLabel: UILabel!
    @IBOutlet var speedSlider: UISlider!
    let stopSpeed: Int = 6

    override func viewDidLoad() {
        super.viewDidLoad()
        serial = BluetoothSerial(delegate: self)
        serial.startScan()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider, forEvent event: UIEvent) {
        motorSpeedLabel.text = "\(Int(sender.value))"
        // If the user stopped moving the slider
        if let touchEvent = event.allTouches?.first, case .ended = touchEvent.phase {
            changeServoSpeed(speed: Int(sender.value))
        }
    }
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            changeServoSpeed(speed: 90)
        case 1:
            changeServoSpeed(speed: stopSpeed)
        case 2:
            changeServoSpeed(speed: -90)
        default:
            changeServoSpeed(speed: stopSpeed)
        }
    }
    
    
    func changeServoSpeed(speed: Int) {
        speedSlider.value = Float(speed)
        motorSpeedLabel.text = "\(speed)"
        let s = speed + 90
        serial.sendMessageToDevice("setSpeed:\(s)\n")
    }
    
    @IBAction func movePressedDown(_ sender: Any) {
        changeServoSpeed(speed: 90)
    }
    
    @IBAction func moveUnpressed(_ sender: Any) {
        changeServoSpeed(speed: stopSpeed)
    }
    
    
    func setBluetooth(status: BluetoothStatus) {
        switch status {
        case .off:
            bluetoothStatusLabel.text = "Bluetooth Off"
            bluetoothStatusLabel.textColor = UIColor.red
        case .searching:
            bluetoothStatusLabel.text = "Bluetooth Searching..."
            bluetoothStatusLabel.textColor = UIColor.orange
        case .connected:
            bluetoothStatusLabel.text = "Connected"
            bluetoothStatusLabel.textColor = UIColor.green
        case .stopped:
            bluetoothStatusLabel.text = "Bluetooth Disconnected and Not Searching"
            bluetoothStatusLabel.textColor = UIColor.red
        case .unknown:
            bluetoothStatusLabel.text = "Unknown"
            bluetoothStatusLabel.textColor = UIColor.red
        }
    }
    
}

extension ViewController: BluetoothSerialDelegate {
    func serialDidChangeState() {
        switch serial.centralManager.state {
        case .poweredOff:
            setBluetooth(status: .off)
        case .poweredOn:
            setBluetooth(status: .searching)
            serial.startScan()
        default:
            setBluetooth(status: .unknown)
        }
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
       setBluetooth(status: .stopped)
    }
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        if peripheral.name == "ARBOT" {
            serial.connectToPeripheral(peripheral)
            setBluetooth(status: .connected)
        }
    }
    
    func queueWork(task: MoveTask) {
        
    }
    
}

