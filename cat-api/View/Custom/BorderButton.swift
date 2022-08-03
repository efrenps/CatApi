//
//  BorderButton.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//


import UIKit

//@IBDesignable
class BorderButton: UIButton {
    var backgroundLayer: CAShapeLayer!
    
    @IBInspectable
    var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.CatApi.morningColor
    
    var fillColor: UIColor = .white
    
    @IBInspectable
    var leftPadding: CGFloat = 20
    
    @IBInspectable
    var rightPadding: CGFloat = 20
    
    override var isEnabled: Bool {
        didSet {
            if (!self.isEnabled) {
                self.fillColor = UIColor.CatApi.lightGray
                self.borderColor = UIColor.CatApi.silverGray
                
                self.setTitleColor(UIColor.CatApi.gray, for: .normal)
            } else {
                self.fillColor = .white
                self.borderColor = UIColor.CatApi.morningColor
                self.setTitleColor(UIColor.CatApi.morningColor, for: .normal)
            }
            
            self.layoutSubviews()
        }
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
        
        if (self.backgroundLayer == nil) {
            self.backgroundLayer = CAShapeLayer()
            
            self.backgroundLayer.lineWidth = 1.0
            
            self.layer.insertSublayer(self.backgroundLayer, at: 0)
        }
        
        self.backgroundLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.backgroundLayer.fillColor = self.fillColor.cgColor
        self.backgroundLayer.strokeColor = self.borderColor.cgColor
    }
    
    func sharedInit() {
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.cornerRadius
        
        self.setTitleColor(UIColor.CatApi.morningColor, for: .normal)
    }
}
