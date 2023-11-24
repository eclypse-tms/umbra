//
//  UmbraButton.swift
//  umbra
//
//  Created by Turker Nessa Kucuk on 11/15/23.
//

import UIKit

@IBDesignable
class UmbraButton: UIButton {
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
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray
    
    @IBInspectable var shadowOffset: CGPoint = CGPoint(x: 1, y: 1)
    
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    
    @IBInspectable var shadowBlurRadius: CGFloat = 3.0
    
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
            
            //corner radius more than this value doesn't make visual sense
            let maxAllowedCornerRadius: CGFloat = frame.height/2.0
            
            if let validConfiguration = self.configuration {
                //this button uses UIButton.Configuration?
                switch validConfiguration.cornerStyle {
                case .fixed:
                    //when fixed is selected, the system uses the corner radius on the background configuration
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: validConfiguration.background.cornerRadius).cgPath
                case .dynamic:
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: validConfiguration.background.cornerRadius).cgPath
                case .small:
                    //when small is selected, the system appears to be using approximately 12% of the height as the corner radius
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: min((frame.height * 0.12), maxAllowedCornerRadius)).cgPath
                case .medium:
                    //when medium is selected, the system appears to be using approximately 18% of the height as the corner radius
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: min((frame.height * 0.18), maxAllowedCornerRadius)).cgPath
                case .large:
                    //when large is selected, the system appears to be using approximately 24% of the height as the corner radius
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: min((frame.height * 0.24), maxAllowedCornerRadius)).cgPath
                case .capsule:
                    //when capsule is selected, the system uses the height of the frame to determine what the corner radius should be
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: maxAllowedCornerRadius).cgPath
                @unknown default:
                    shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: .zero).cgPath
                }
            } else {
                //this button type does not use button configuration - check the main layer's corner radius
                shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
            }
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
