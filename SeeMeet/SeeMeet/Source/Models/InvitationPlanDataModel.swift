//
//  InvitationPlanDataModel.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/21.
//

import Foundation

// MARK: - Main
struct InvitationPlanData: Codable {
    let status: Int
    let success: Bool
    let data: [ScheduleData]?
}

// MARK: - Datum
struct ScheduleData: Codable {
    let id: Int
    let invitationTitle, date, start, end: String
}
