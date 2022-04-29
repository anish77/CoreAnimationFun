//
//  DetailViewController.swift
//  AnimationFun
//
//  Created by Ana Cvasniuc on 28/04/22.
//

import UIKit



class DetailViewController: UIViewController{
    //let cellAnimation: [String] = ["Move", "Scale", "Rotate", "Shake", "Circling"]
    
    //let redView = UIView(frame: CGRect(x: 20, y: 100, width: 140, height: 100))
    let redView = UIView()
    let _width: CGFloat = 140
    let _height: CGFloat = 100
    
    //circle
    let redCircle = UIImageView()
    let _diametr: CGFloat = 300
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //view.addSubview(redCircle)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let titels = title
        switch titels {
        case "Move":
            position()
            move()
        case "Scale":
            position()
            scale()
        case "Rotate":
            position()
            rotate()
        case "Shake":
            position()
            shake()
        case "Circling":
            drowCircle()
            
        default:
            print("Errore")
        }
        
    }
    
    func position(){
        
        redView.backgroundColor = .systemRed
        view.addSubview(redView)
        //the retangle is positionated in the Center
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)
    }
    
    func drowCircle(){
        
        redView.backgroundColor = .systemRed
               view.addSubview(redView)
               view.addSubview(redCircle)
        
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)
        
        //draw circle
        redCircle.frame = CGRect(x: view.bounds.midX - _diametr/2,
                                 y: view.bounds.midY - _diametr/2,
                                 width: _diametr, height: _diametr)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: _diametr, height: _diametr))
        
        let img = renderer.image { ctx in
            let retangle = CGRect(x: 0, y: 0, width: _diametr, height: _diametr)
            
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.setLineWidth(1)
            ctx.cgContext.addEllipse(in: retangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        redCircle.image = img
        animateCircle()
    }
    
    func move(){
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 20 + 140 / 2 // this value from readView (x + with / 2 )
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2) //update to final position
        
    }
    
    func scale(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.4
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeScale(2, 2, 1)
        
    }
    
    func rotate(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 4
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
        
    }
    
    func shake(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        redView.layer.add(animation, forKey: "shake")
    }
    
    func animateCircle(){
        
        
        let boundingRect = CGRect(x: -_diametr/2, y: -_diametr/2, width: _diametr, height: _diametr)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 2
        orbit.isAdditive = true
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        
        redView.layer.add(orbit, forKey: "redbox")
    }
}
