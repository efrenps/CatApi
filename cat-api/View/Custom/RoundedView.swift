//
//  RoundedView.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import UIKit

//@IBDesignable
class RoundedView: UIView {
    var backgroundLayer: CAShapeLayer!
    
    @IBInspectable
    var cornerRadius: CGFloat = 6.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    var fillColor: UIColor = .white {
        didSet {
            self.backgroundLayer?.fillColor = self.fillColor.cgColor
        }
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        
        self.sharedInit()
        
        self.fillColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        sharedInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setBackground()
        
        self.layer.cornerRadius = self.cornerRadius
    }
    
    func sharedInit() {
        if (self.backgroundColor != nil) {
            self.fillColor = self.backgroundColor!
        }
        
        self.backgroundColor = .clear
        
        if (self.bounds.size.height > 0 && self.bounds.size.height < 10) {
            self.cornerRadius = self.bounds.size.height / 2
        }
    }
    
    private func setBackground() {
        if (self.backgroundLayer == nil) {
            self.backgroundLayer = CAShapeLayer()
            
            self.backgroundLayer.fillColor = self.fillColor.cgColor
            
            self.layer.insertSublayer(self.backgroundLayer, at: 0)
        }
        
        self.backgroundLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
    }
}
