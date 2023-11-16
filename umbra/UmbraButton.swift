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
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @IBInspectable var hasShadows: Bool = false
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: -3.0)
    
    @IBInspectable var shadowOpacity: CGFloat = 0.5
    
    @IBInspectable var shadowBlurRadius: CGFloat = 3.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if hasShadows {
            if _shadowLayer != nil {
                _shadowLayer?.removeFromSuperlayer()
                _shadowLayer = nil
            }
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.configuration?.background.cornerRadius ?? .zero).cgPath
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.fillColor = backgroundColor?.cgColor
            shadowLayer.shadowColor = self.shadowColor.cgColor
            shadowLayer.shadowOffset = self.shadowOffset
            shadowLayer.shadowOpacity = Float(self.shadowOpacity)
            shadowLayer.shadowRadius = self.shadowBlurRadius
            layer.insertSublayer(shadowLayer, at: 0)
            _shadowLayer = shadowLayer
        } else {
            _shadowLayer?.removeFromSuperlayer()
            _shadowLayer = nil
        }
    }
    

    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        
    }
}
