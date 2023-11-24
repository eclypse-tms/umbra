//
//  UmbraButtonOldApi.swift
//  umbra
//
//  Created by Turker Nessa Kucuk on 11/15/23.
//

import UIKit

@IBDesignable
class UmbraButtonOldApi: UIButton {
    private var _shadowLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBInspectable var hasShadow: Bool = false {
        didSet {
            setShadowLayer()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = CGFloat(0) {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var buttonBackgroundColor: UIColor = UIColor.clear {
        didSet {
            self.backgroundColor = buttonBackgroundColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = CGFloat(3) {
        didSet {
            layer.cornerRadius = cornerRadius
            setShadowLayer()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
        didSet {
            setShadowLayer()
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint = CGPoint(x: 1, y: 1) {
        didSet {
            setShadowLayer()
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0.5 {
        didSet {
            setShadowLayer()
        }
    }
    
    @IBInspectable var shadowBlurRadius: CGFloat = 2.0 {
        didSet {
            setShadowLayer()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadowLayer()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setShadowLayer()
    }
    
    private func setShadowLayer() {
        if hasShadow {
            _shadowLayer?.removeFromSuperlayer()
            _shadowLayer = nil
            
            let shadowLayer = CAShapeLayer()
            
            //this button type does not use button configuration - check the main layer's corner radius
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
            
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.fillColor = backgroundColor?.cgColor
            shadowLayer.shadowColor = self.shadowColor.cgColor
            shadowLayer.shadowOffset = CGSize(width: self.shadowOffset.x, height: self.shadowOffset.y)
            shadowLayer.shadowOpacity = Float(shadowOpacity)
            shadowLayer.shadowRadius = self.shadowBlurRadius
            layer.insertSublayer(shadowLayer, at: 0)
            _shadowLayer = shadowLayer
        } else {
            _shadowLayer?.removeFromSuperlayer()
            _shadowLayer = nil
        }
    }
}
