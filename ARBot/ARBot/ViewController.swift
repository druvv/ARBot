//
//  ViewController.swift
//  ARBot
//
//  Created by Dhruv  Sringari on 9/27/17.
//  Copyright © 2017 Dhruv Sringari. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    enum BluetoothStatus {
        case off
        case searching
        case connected
        case stopped
        case unknown
    }
    
    var serial: BluetoothSerial!
    @IBOutlet var bluetoothStatusLabel: UILabel!
    var bluetoothStatus: BluetoothStatus = .off
    @IBOutlet var motorSpeedLabel: UILabel!
    let stopSpeed: Int = 94

    override func viewDidLoad() {
        super.viewDidLoad()
        serial = BluetoothSerial(delegate: self)
        serial.startScan()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        changeServoSpeed(speed: Int(sender.value))
    }
    
    func changeServoSpeed(speed: Int) {
        serial.sendMessageToDevice("setSpeed:\(speed)\n")
        motorSpeedLabel.text = "\(speed)"
    }
    
    @IBAction func movePressedDown(_ sender: Any) {
        changeServoSpeed(speed: 180)
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
        if peripheral.name == "MLT-BT05" {
            serial.connectToPeripheral(peripheral)
            setBluetooth(status: .connected)
        }
    }
    
}

