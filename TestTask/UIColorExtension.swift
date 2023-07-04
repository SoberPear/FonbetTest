//
//  UIColorExtension.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import UIKit

// это расширение добавляет инициализатор для того, чтобы полученный с сервера цвет в формате HEX преобразовать в объект UIColor
extension UIColor {
    convenience init?(hex: String) {
        var hexFormatted = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
