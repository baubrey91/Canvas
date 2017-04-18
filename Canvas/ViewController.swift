//
//  ViewController.swift
//  Canvas
//
//  Created by Brandon on 4/17/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayOriginalCenter = trayView.center

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)

        //let point = panGestureRecognizer.location(in: parent?.view)

        if panGestureRecognizer.state == .began {
            
        } else if panGestureRecognizer.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == .ended {
            if velocity.y > 0 {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + 175)
                //moving down
            } else {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y)
                //moving up
            }
        }
    }
}

