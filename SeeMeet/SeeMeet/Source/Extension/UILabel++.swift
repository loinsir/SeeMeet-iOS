//
//  UILabel++.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/12.
//
import UIKit

extension UILabel {
    func setTextFontAttribute(defaultText: String, containText: String, changingFont: UIFont, color: UIColor) -> NSAttributedString {
        let text: String = defaultText
        let changeText = NSMutableAttributedString(string: text)
        changeText.addAttribute(.font, value: changingFont, range: (text as NSString).range(of: containText))
        changeText.addAttribute(.foregroundColor, value: color, range: (text as NSString).range(of: containText))
        return changeText
    }
    
    func setTextLineAttribute(defaultText: String, value: CGFloat) -> NSAttributedString{
        let text: String = defaultText
        let changeText = NSMutableAttributedString(string: text)
        changeText.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(0 ... changeText.length-1))
        return changeText
    }
}
