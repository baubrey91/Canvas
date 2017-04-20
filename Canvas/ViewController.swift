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
    
    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayOriginalCenter = trayView.center
        
        trayCenterWhenOpen = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y)
        trayCenterWhenClosed = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + 175)

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTrayTapGesture(_ sender: UITapGestureRecognizer) {
        if trayView.center.y == trayOriginalCenter.y {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: { self.trayView.center = self.trayCenterWhenClosed }, completion: nil)

        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: { self.trayView.center = self.trayCenterWhenOpen }, completion: nil)
        }
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
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: { self.trayView.center = self.trayCenterWhenClosed }, completion: nil)
                //moving down
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: { self.trayView.center = self.trayCenterWhenOpen }, completion: nil)
                //moving up
            }
        }
    }
    
    @IBAction func onFacePanGesture(_ sender: UIPanGestureRecognizer) {
        
    }
}
