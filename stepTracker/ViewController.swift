//
//  ViewController.swift
//  stepTracker
//
//  Created by Mhatre, Aniket on 4/25/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var stepCountLabel: UILabel!
    
    private let pedometer = CMPedometer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStart(_ sender: UIButton) {
        if(CMPedometer.isStepCountingAvailable()) {
            pedometer.startUpdates(from: Date(), withHandler: { (data, error) in
                
                DispatchQueue.main.sync(execute: {
                    if(error == nil){
                        if let stepCount = data?.numberOfSteps {
                            self.stepCountLabel.text = "\(stepCount)"
                        }
                    }
                })
            })
        }
    }
    
    @IBAction func onStop(_ sender: UIButton) {
        if(CMPedometer.isStepCountingAvailable()) {
            pedometer.stopUpdates() //hack: call pedometer.stopUpdates() for expected behavoiur
            stepCountLabel.text = "0"
        }
    }
}

