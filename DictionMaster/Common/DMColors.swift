//
//  DMColors.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 07/02/24.
//

import UIKit

extension UIColor {
    static func DMstandardWord() -> UIColor {
        return self.hexStringToUIColor(hex: "#052D39")
    }
    
    static func DMstandardBackground() -> UIColor {
        return self.hexStringToUIColor(hex: "#91A9B1")
    }
    
    static func DMalternativeWord() -> UIColor {
        return self.hexStringToUIColor(hex: "#052D3980")
    }
    
    static func DMButton() -> UIColor {
        return self.hexStringToUIColor(hex: "#5BD6FD")
    }
    
    private static func hexStringToUIColor (hex:String) -> UIColor {
         var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

         if (cString.hasPrefix("#")) {
             cString.remove(at: cString.startIndex)
         }

         if ((cString.count) != 6) {
             return UIColor.gray
         }

         var rgbValue:UInt64 = 0
         Scanner(string: cString).scanHexInt64(&rgbValue)

         return UIColor(
             red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
             alpha: CGFloat(1.0)
         )
     }
}
