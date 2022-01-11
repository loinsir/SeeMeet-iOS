//
//  UITextField++.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/12.
//

import UIKit

extension UITextField {
  func addLeftPadding(width : CGFloat = 10) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
