//
//  RoundedShadowView.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import UIKit

//@IBDesignable
class RoundedShadowView: RoundedView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (self.backgroundLayer != nil) {
            self.backgroundLayer.shadowColor = UIColor.black.cgColor
            self.backgroundLayer.shadowPath = self.backgroundLayer.path
            self.backgroundLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.backgroundLayer.shadowOpacity = 0.1
            self.backgroundLayer.shadowRadius = 5
        }
    }
}
