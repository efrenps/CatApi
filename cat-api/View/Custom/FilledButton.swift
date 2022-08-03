//
//  FilledButton.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//


import UIKit

//@IBDesignable
class FilledButton: BorderButton {
    override var isEnabled: Bool {
        didSet {
            if (self.isEnabled) {
                self.fillColor = UIColor.CatApi.morningColor
                self.borderColor = UIColor.CatApi.morningColor
                
                self.setTitleColor(.white, for: .normal)
            }
            else {
                self.fillColor = UIColor.CatApi.lightGray
                self.borderColor = UIColor.CatApi.silverGray
                
                self.setTitleColor(UIColor.CatApi.gray, for: .normal)
            }
            
            self.layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func sharedInit() {
        self.fillColor = UIColor.CatApi.morningColor
        
        self.setTitleColor(.white, for: .normal)
    }
}
