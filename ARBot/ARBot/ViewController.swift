//
//  ViewController.swift
//  ARBot
//
//  Created by Dhruv  Sringari on 9/27/17.
//  Copyright © 2017 Dhruv Sringari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: BluetoothSerialDelegate {
    func serialDidChangeState() {
        <#code#>
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        <#code#>
    }
    
    
}

