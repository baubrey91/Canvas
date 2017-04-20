//
//  ViewController.swift
//  Canvas
//
//  Created by Brandon on 4/17/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    
    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    var faceOriginalCenter: CGPoint!

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
            trayOriginalCenter = self.trayView.center
            
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
    
    
    @IBAction func onFacePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translation(in: view)
        let y = (panGestureRecognizer.view?.frame.origin.y)! + (panGestureRecognizer.view?.superview?.frame.origin.y)!
        
        if panGestureRecognizer.state == .began {
            
            faceOriginalCenter = panGestureRecognizer.view?.center

            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(panGestureRecognizer:)))
           // let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(pinchGestureRecognizer:)))
            let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(rotateGestureRecognizer:)))

            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGesture)
           // newlyCreatedFace.addGestureRecognizer(pinchGesture)
            newlyCreatedFace.addGestureRecognizer(rotateGesture)
            //pinchGesture.delegate = self
            //rotateGesture.delegate = self
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
        }

        if panGestureRecognizer.state == .changed {
            
            newlyCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: y + translation.y)
        }
    }
    
    func didPan(panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        
        if panGestureRecognizer.state == .changed {
            
            panGestureRecognizer.view?.transform = CGAffineTransform(scaleX: (translation.x/100) + 1, y: (translation.y/100) + 1)
        }
        
        if panGestureRecognizer.state == .ended {
            panGestureRecognizer.view?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func didPinch(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        
        let scale = pinchGestureRecognizer.scale
        
        if pinchGestureRecognizer.state == .changed {
            
            pinchGestureRecognizer.view?.transform = CGAffineTransform(scaleX: scale , y: scale)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func didRotate(rotateGestureRecognizer: UIRotationGestureRecognizer) {
        
        if rotateGestureRecognizer.state == .changed {

            rotateGestureRecognizer.view?.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180))
        }
    }
}
