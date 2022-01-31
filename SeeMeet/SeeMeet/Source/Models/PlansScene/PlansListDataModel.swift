// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeDataModel = try? newJSONDecoder().decode(HomeDataModel.self, from: jsonData)

import Foundation

// MARK: - HomeDataModel
struct PlansListDataModel: Codable {
    let status: Int
    let success: Bool?
    let data: PlansListData?
    let message: String?
}

// MARK: - DataClass
struct PlansListData: Codable {
    let invitations: [Invitation]
    let confirmedAndCanceld: [ConfirmedAndCanceld]
}

// MARK: - ConfirmedAndCanceld
struct ConfirmedAndCanceld: Codable {
    let id: Int
    let invitationTitle: String
    let isCancled, isConfirmed: Bool
    let guests: [Guest]
    let planID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case invitationTitle = "invitation_title"
        case isCancled = "is_cancled"
        case isConfirmed = "is_confirmed"
        case guests
        case planID = "planId"
    }
}

// MARK: - Guest
struct Guest: Codable {
    let id: Int
    let username: String
    let impossible: Bool?
    let isResponse: Bool?
}

// MARK: - Invitation
struct Invitation: Codable {
    let id: Int
    let hostID: Int?
    let invitationTitle, invitationDesc: String
    let isConfirmed, isCancled: Bool
    let createdAt: String
    let isDeleted: Bool
    let guests: [Guest]?
    let isReceived, isResponse: Bool
    let host: Host?

    enum CodingKeys: String, CodingKey {
        case id
        case hostID = "host_id"
        case invitationTitle = "invitation_title"
        case invitationDesc = "invitation_desc"
        case isConfirmed = "is_confirmed"
        case isCancled = "is_cancled"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
        case guests, isReceived, isResponse, host
    }
}

// MARK: - Host
struct Host: Codable {
    let id: Int
    let username: String
}
