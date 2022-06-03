//
//  likeControl.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 09.05.2022.
//

import UIKit

@IBDesignable

class LikeControl: UIControl {

    @IBInspectable var filled: Bool = false
    @IBInspectable var strokeWidth: CGFloat = 2.0

    @IBInspectable var strokeColor: UIColor?
    
    let numberOfLikes = UILabel()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        strokeColor = UIColor.red
        
        let bezierPath = UIBezierPath(heartIn: self.bounds)

        if self.strokeColor != nil {
            self.strokeColor!.setStroke()
        } else {
            self.tintColor.setStroke()
        }

        bezierPath.lineWidth = self.strokeWidth
        bezierPath.stroke()
        
        if filled {UIColor.red.setFill()} else {UIColor.white.setFill()}
        bezierPath.fill()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setupGesture()
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func taped(_ tapGesture: UITapGestureRecognizer) {
        filled.toggle()
        sendActions(for: .valueChanged)
    }
}

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()

        //Calculate Radius of Arcs using Pythagoras
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2

        //Left Hand Curve
        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        //Top Centre Dip
        self.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))

        //Right Hand Curve
        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)

        //Right Bottom Line
        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))

        //Left Bottom Line
        self.close()
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
