//
//  Gradient.swift
//  coctails
//
//  Created by AnnaEvgen on 08.06.2022.
//

import UIKit
//
//extension UIView {
//
//    func setGradient(colors: [UIColor])  -> CAGradientLayer {
//        return setGradient(colours: colors, locations: nil)
//    }
//
//    func setGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
//            let gradient: CAGradientLayer = CAGradientLayer()
//            gradient.frame = self.bounds
//            gradient.colors = colours.map { $0.cgColor }
//            gradient.locations = locations
//            self.layer.insertSublayer(gradient, at: 0)
//            return gradient
//        }
//
//}
//
//class GradientColors {
//    var gl: CAGradientLayer!
//
//    init() {
//        self.gl = CAGradientLayer()
//        self.gl.colors = [UIColor.red.cgColor, UIColor.purple.cgColor]
//        self.gl.locations = [0.0, 1.1]
//    }
//}

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        
        (layer as! CAGradientLayer).colors = [UIColor.red.cgColor, UIColor.purple.cgColor]
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0.5, y: 0)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 0.5, y: 1)

    }
}
