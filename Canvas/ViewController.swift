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
    @IBOutlet weak var trayArrowImage: UIImageView!
    
    var newlyCreatedFace: UIImageView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var faceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayOriginalCenter = trayView.center
        trayCenterWhenOpen = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y)
        trayCenterWhenClosed = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + 220)
    }
    
    @IBAction func onTrayTapGesture(_ sender: UITapGestureRecognizer) {
        if trayView.center.y == trayOriginalCenter.y {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                self.trayView.center = self.trayCenterWhenClosed
                self.trayArrowImage.transform = self.trayArrowImage.transform.rotated(by: CGFloat(M_PI))

            }, completion: nil)

        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                self.trayView.center = self.trayCenterWhenOpen
                self.trayArrowImage.transform = self.trayArrowImage.transform.rotated(by: CGFloat(M_PI))

            }, completion: nil)
        }
    }

    @IBAction func onTrayPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        let velocity = panGestureRecognizer.velocity(in: view)
        let location = panGestureRecognizer.translation(in: view).y + self.view.bounds.maxY

        //let point = panGestureRecognizer.location(in: parent?.view)

        if panGestureRecognizer.state == .began {
            trayOriginalCenter = self.trayView.center
            
        } else if panGestureRecognizer.state == .changed {
        
            /*if location < trayOriginalCenter.y {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: (trayOriginalCenter.y + (translation.y/10)))
            } else {*/
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            //}
        } else if panGestureRecognizer.state == .ended {
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                    self.trayArrowImage.transform = self.trayArrowImage.transform.rotated(by: CGFloat(M_PI))
                }, completion: nil)
                //moving down
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: [], animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                    self.trayArrowImage.transform = self.trayArrowImage.transform.rotated(by: CGFloat(M_PI))
                }, completion: nil)
                //moving up
            }
        }
    }
    
    @IBAction func onFacePanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translation(in: view)
        let y = (panGestureRecognizer.view?.frame.origin.y)! + (panGestureRecognizer.view?.superview?.frame.origin.y)!
        
        if panGestureRecognizer.state == .began {
            
            //faceOriginalCenter = panGestureRecognizer.view?.center

            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)

            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            self.faceOriginalCenter = newlyCreatedFace.center

            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(panGestureRecognizer:)))
            newlyCreatedFace.isUserInteractionEnabled = true

            newlyCreatedFace.addGestureRecognizer(panGesture)

            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(pinchGestureRecognizer:)))
            newlyCreatedFace.addGestureRecognizer(pinchGesture)
            pinchGesture.delegate = self

            let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(rotateGestureRecognizer:)))
            newlyCreatedFace.addGestureRecognizer(rotateGesture)
            rotateGesture.delegate = self
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(tapGestureRecognizer:)))
            tapGesture.numberOfTapsRequired = 2
            newlyCreatedFace.addGestureRecognizer(tapGesture)
        }

        if panGestureRecognizer.state == .changed {
            newlyCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: y + translation.y)
        }
    }
    
    func didPan(panGestureRecognizer: UIPanGestureRecognizer) {
//        
//        let translation = panGestureRecognizer.translation(in: view)
//        if panGestureRecognizer.state == UIGestureRecognizerState.began{
//            newlyCreatedFace = panGestureRecognizer.view as! UIImageView
//            faceOriginalCenter = newlyCreatedFace.center
//            
//            
//        }else if panGestureRecognizer.state == UIGestureRecognizerState.changed{
//            newlyCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: faceOriginalCenter.y + translation.y)
//        }else if panGestureRecognizer.state == UIGestureRecognizerState.ended{
//            
//        }

        let translation = panGestureRecognizer.translation(in: view)
        
        if panGestureRecognizer.state == .changed {
            
            panGestureRecognizer.view?.transform = CGAffineTransform(scaleX: (translation.x/100) + 1, y: (translation.y/100) + 1)
        }
        
        if panGestureRecognizer.state == .ended {
            panGestureRecognizer.view?.transform = .identity
        }
    }
    
    func didPinch(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        
        let scale = pinchGestureRecognizer.scale
        newlyCreatedFace = pinchGestureRecognizer.view as! UIImageView
        newlyCreatedFace.transform = newlyCreatedFace.transform.scaledBy(x: scale, y: scale)
        pinchGestureRecognizer.scale = 1
        
        /*let scale = pinchGestureRecognizer.scale
        
        if pinchGestureRecognizer.state == .changed {
            
            pinchGestureRecognizer.view?.transform = CGAffineTransform(scaleX: scale , y: scale)
        }
        
        if pinchGestureRecognizer.state == .ended {
            
           // pinchGestureRecognizer.view?.transform = CGAffineTransform(scaleX: scale , y: scale)
        }*/
    }
    
    func didRotate(rotateGestureRecognizer: UIRotationGestureRecognizer) {
        let rotation = rotateGestureRecognizer.rotation
        newlyCreatedFace = rotateGestureRecognizer.view as! UIImageView
        newlyCreatedFace.transform = newlyCreatedFace.transform.rotated(by: rotation)
        rotateGestureRecognizer.rotation = 0
        /*let rotation = rotateGestureRecognizer.rotation
        
        if rotateGestureRecognizer.state == .changed {
            rotateGestureRecognizer.view?.transform = CGAffineTransform(rotationAngle: CGFloat((45 * Double.pi) / 180) * rotation)
        }
        
        if rotateGestureRecognizer.state == .ended {
           // rotateGestureRecognizer.view?.transform = CGAffineTransform(rotationAngle: CGFloat((45 * Double.pi) / 180) * rotation)
        }*/
    }
    
    func didDoubleTap(tapGestureRecognizer: UITapGestureRecognizer) {
        tapGestureRecognizer.view?.removeFromSuperview()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
