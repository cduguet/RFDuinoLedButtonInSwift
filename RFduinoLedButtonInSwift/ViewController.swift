//
//  ViewController.swift
//  RFDuinoLedButtonInSwift
//
//  Created by Cristian Duguet on 9/14/15.
//  Copyright (c) 2015 TrainFES. All rights reserved.
//

import UIKit


class ViewController: UIViewController, RFduinoDelegate {
    
    var rfduino = RFduino()
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var label2: UILabel!
    @IBOutlet var image1: UIImageView!
    //    var on: UIImage
    //    var off: UIImage
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        rfduino.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func disconnect(sender: String) {
        println("Disconnecting...")
        rfduino.disconnect()
    }
    
    func sendByte(byte: UInt8) {
        var tx: [UInt8] = [byte]
        var data = NSData(bytes: &tx, length: sizeof(UInt8))
        rfduino.send(data)
        //        uint8_t tx[1] = { byte };
        //        NSData *data = [NSData dataWithBytes:(void*)&tx length:1];
        //        [rfduino send:data];
    }
    
    
    @IBAction func buttonTouchDown(sender: AnyObject) {
        println("Touch Down")
        self.sendByte(1)
    }
    
    @IBAction func buttonTouchUpInside(sender: AnyObject) {
        println("TouchUpInside")
        self.sendByte(0)
    }
    
    func didReceive(data: NSData!) {
        println("Received Data")
        var value : [UInt8] = [0]; data.getBytes(&value, length: 1)
        var len = data.length
        
        if (value[0] == 1) { image1.image = UIImage(named: "on")}
        else { image1.image = UIImage(named: "off")}
        
        //        NSLog(@"RecievedData");
        //
        //        const uint8_t *value = [data bytes];
        //        // int len = [data length];
        //
        //        NSLog(@"value = %x", value[0]);
        //
        //        if (value[0])
        //        [image1 setImage:on];
        //        else
        //        [image1 setImage:off];
    }
}

