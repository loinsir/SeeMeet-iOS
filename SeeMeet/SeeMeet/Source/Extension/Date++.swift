//
//  Date++.swift
//  SeeMeet_iOS
//
//  Created by 박익범 on 2022/01/05.
//

import Foundation


extension Date {
    
    static func getCurrentYear() -> String{
        let nowDate = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // 2020-08-13 16:30
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    static func getCurrentMonth() -> String{
        let nowDate = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM" // 2020-08-13 16:30
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    static func getCurrentDay() -> String{
        let nowDate = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd" // 2020-08-13 16:30
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
}

