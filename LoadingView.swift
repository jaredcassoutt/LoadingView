//
//  LoadingView.swift
//  Styvio
//
//  Created by Jared Cassoutt on 5/12/21.
//

import UIKit

protocol LoadingViewProtocol {
    var loadingView: LoadingView {get set}
}

extension LoadingViewProtocol where Self: UIView {
    func startLoading() {
            addSubview(loadingView)
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
                loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
                loadingView.widthAnchor.constraint(equalToConstant: CGFloat(80)),
                loadingView.heightAnchor.constraint(equalToConstant: CGFloat(80)),
            ])
        loadingView.isHidden = false
        loadingView.animateCircle(duration: 1, repeats: true)
    }
    
    func stopLoading() {
        loadingView.isHidden = true
    }
}

extension LoadingViewProtocol where Self: UIViewController {
    func startLoading() {
            view.addSubview(loadingView)
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingView.widthAnchor.constraint(equalToConstant: CGFloat(80)),
                loadingView.heightAnchor.constraint(equalToConstant: CGFloat(80)),
            ])
        loadingView.isHidden = false
        loadingView.animateCircle(duration: 1, repeats: true)
    }
    
    func stopLoading() {
        loadingView.isHidden = true
    }
}


class LoadingView: UIView {
    
//MARK: - Properties and Init
    
    let circleLayer = CAShapeLayer()
    private var circlePath : UIBezierPath = .init()
    let size : CGFloat = 80
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: size, height: size))
        tag = 100
        addShadow(shadowColor: UIColor.label.cgColor, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.3, shadowRadius: 3)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = size/8
        self.layer.addSublayer(circleLayer)
        calculateCirclePath()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.lineWidth = 5.0
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        self.layer.addSublayer(circleLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Private UI Setup Methods
    
    private func calculateCirclePath() {
        self.circlePath = UIBezierPath(arcCenter: CGPoint(x: size / 2, y: size / 2), radius: size / 3, startAngle: 0.0, endAngle: CGFloat(Double.pi*2), clockwise: true)
    }
    
    override func layoutSubviews() {
        circleLayer.frame = self.layer.bounds
    }
    
    func animateCircle(duration: TimeInterval, repeats: Bool) {
        // Setup the CAShapeLayer with the path, colors, and line width
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
}

