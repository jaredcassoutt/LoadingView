//  LoadingView.swift
//  Created by Jared Cassoutt on 5/12/21.

import UIKit

class LoadingView: UIView {
    
    let circleLayer = CAShapeLayer()
    
    private var circlePath : UIBezierPath = .init()
    let size : CGFloat = 75
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        layer.cornerRadius = size/8
        addShadow(shadowColor: UIColor.label.cgColor, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.3, shadowRadius: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        if let topView = UIApplication.topViewController()?.view {
            topView.addSubview(self)
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
                self.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
                self.widthAnchor.constraint(equalToConstant: CGFloat(size)),
                self.heightAnchor.constraint(equalToConstant: CGFloat(size)),
            ])
            addShadow(shadowColor: UIColor.label.cgColor, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.3, shadowRadius: 3)
            backgroundColor = .secondarySystemBackground
            self.layer.addSublayer(circleLayer)
            calculateCirclePath()
            animateCircle(duration: 1, repeats: true)
        }
    }
    
    func calculateCirclePath() {
        self.circlePath = UIBezierPath(arcCenter: CGPoint(x: size / 2, y: size / 2), radius: size / 3, startAngle: 0.0, endAngle: CGFloat(Double.pi*2), clockwise: true)
    }
    
    override func layoutSubviews() {
        circleLayer.frame = self.layer.bounds
    }
    
    private func animateCircle(duration: TimeInterval, repeats: Bool) {
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = 5.0
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        self.layer.addSublayer(circleLayer)
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.repeatCount = repeats ? .infinity : 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        circleLayer.strokeEnd = 0
        circleLayer.add(animation, forKey: "animateCircle")
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.repeatCount = repeats ? .infinity : 1
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi*3
        rotationAnimation.duration = duration
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        circleLayer.add(rotationAnimation, forKey: nil)
        
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.repeatCount = repeats ? .infinity : 1
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.duration = duration
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        circleLayer.add(fadeAnimation, forKey: nil)
    }
    
    func stopLoading() {
        self.removeFromSuperview()
    }
}
