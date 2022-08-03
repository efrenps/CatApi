//
//  ColorExtension.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//


import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

extension UIColor {
    struct CatApi {
        static let cyan = UIColor(hex: 0x7BDEDB)
        static let darkGray = UIColor(hex: 0x333333)
        static let fucsia = UIColor(hex: 0xBE207A)
        static let gray = UIColor(hex: 0x757575)
        static let green = UIColor(hex: 0x138468)
        static let lightBlue = UIColor(hex: 0x0B9CE5)
        static let morningColor = UIColor(hex: 0x009DD6)
        static let lightGray = UIColor(hex: 0xF6F6F6)
        static let silverGray = UIColor(hex: 0xD6D6D6)
        static let metalGray = UIColor(hex: 0x8894A1)
        static let lightMetalGray = UIColor(hex: 0xE2E8EE)
        static let purple = UIColor(hex: 0x8230DF)
        static let red = UIColor(hex: 0xEC111A)
        static let darkRed = UIColor(hex: 0xBD051B)
        static let yellow = UIColor(hex: 0xF5C400)
        static let white = UIColor(hex: 0xFFFFFF)
        static let purpleBadge = UIColor(hex: 0x7849B8)
    }
}
