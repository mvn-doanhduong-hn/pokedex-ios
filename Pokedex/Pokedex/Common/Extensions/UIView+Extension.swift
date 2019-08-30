//
//  UIView+Extension.swift
//  Pokedex
//
//  Created by LTT on 8/29/19.
//  Copyright © 2019 LTT. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: Int = 8) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    func setBackgroundGradientColor(fromHexString fromColor: String, toHexString toColor: String) {
        setBackgroundGradientColor(fromColor: UIColor(hexString: fromColor), toColor: UIColor(hexString: toColor))
    }
    
    func setBackgroundGradientColor(fromColor: UIColor, toColor: UIColor) {
        let gradient = CAGradientLayer()
        var bounds = self.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [fromColor.cgColor, toColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = Utils.getImageFrom(gradientLayer: gradient) {
            self.backgroundColor = UIColor(patternImage: image)
        }
    }
}
