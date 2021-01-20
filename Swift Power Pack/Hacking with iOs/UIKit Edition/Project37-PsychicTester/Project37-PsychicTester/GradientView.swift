//
//  GradientView.swift
//  Project37-PsychicTester
//
//  Created by Arnaud Miguet on 20.01.21.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var topColor: UIColor = .white
    @IBInspectable var bottomColor: UIColor = .black
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
