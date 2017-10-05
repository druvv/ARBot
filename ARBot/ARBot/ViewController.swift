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
    var serial: BluetoothSerial!
    @IBOutlet var bluetoothStatusLabel: UILabel!
    @IBOutlet var motorSpeedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        serial = BluetoothSerial(delegate: self)
        if serial.centralManager.state != .poweredOn {
            print("Bluetooth Not Enabled!!!!");
        }
        serial.startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: BluetoothSerialDelegate {
    func serialDidChangeState() {
        switch serial.centralManager.state {
        case .poweredOff:
            bluetoothStatusLabel.text = "Bluetooth Off"
            bluetoothStatusLabel.textColor = UIColor.red
        case .poweredOn
            bluetoothStatusLabel.text = "Bluetooth On"
            bluetoothStatusLabel.textColor = UIColor.green
        default:
            bluetoothStatusLabel.text = "Unknown"
            bluetoothStatusLabel.textColor = UIColor.orange
        }
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        
    }
    
    func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
        print(peripheral)
    }
    
}

