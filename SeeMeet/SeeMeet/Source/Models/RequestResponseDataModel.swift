//
//  InvitationDataModel.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/21.
//

import Foundation

// MARK: - Main
struct RequestResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: RequestPlansResultData?
}

// MARK: - DataClass
struct RequestPlansResultData: Codable {
    let invitation: Invitation
    let guests: [Guest]
    let dates: [[RequestDateElement]]
}

// MARK: - DateElement
struct RequestDateElement: Codable {
    let id, invitationID: Int
    let date, start, end: String

    enum CodingKeys: String, CodingKey {
        case id
        case invitationID = "invitationId"
        case date, start, end
    }
}

// MARK: - Guest
struct RequestGuest: Codable {
    let id: Int
    let username: String
}

// MARK: - Invitation
struct RequestInvitation: Codable {
    let id, hostID: Int
    let invitationTitle, invitationDesc: String
    let isConfirmed, isCancled: Bool
    let createdAt: String
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case hostID = "hostId"
        case invitationTitle, invitationDesc, isConfirmed, isCancled, createdAt, isDeleted
    }
}
