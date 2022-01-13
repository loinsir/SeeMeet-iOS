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
    
    static func getCurrentDate() -> String{
        let nowDate = Date() // 현재의 Date (ex: 2020-08-13 09:14:48 +0000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd" // 2020-08-13 16:30
        let str = dateFormatter.string(from: nowDate)
        return str
    }
    
    static func getCurrentKoreanWeekDay() -> String {
        getKoreanWeekDay(from: Date())
    }
    
    static func getKoreanWeekDay(from date: Date) -> String {
        let currentDay = Calendar.current.component(.weekday, from: date)

        switch currentDay {
        case 1:
            return "일"
        case 2:
            return "월"
        case 3:
            return "화"
        case 4:
            return "수"
        case 5:
            return "목"
        case 6:
            return "금"
        case 7:
            return "토"
        default:
            return "일"
        }
    }
    
}

