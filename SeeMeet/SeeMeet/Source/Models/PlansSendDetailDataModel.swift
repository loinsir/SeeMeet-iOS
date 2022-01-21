// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let plansDetailDataModel = try? newJSONDecoder().decode(PlansDetailDataModel.self, from: jsonData)

import Foundation

// MARK: - PlansDetailDataModel
struct PlansSendDetailDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PlansSendDetailData
}

// MARK: - DataClass
struct PlansSendDetailData: Codable {
    let invitation: PlansSendInvitation
    let invitationDates: [PlansSendInvitationDate]
}

// MARK: - Invitation
struct PlansSendInvitation: Codable {
    let id, hostID: Int
    let invitationTitle, invitationDesc: String
    let isConfirmed, isCancled: Bool
    let createdAt: String
    let isDeleted: Bool
    let host: Host
    let guests: [SendGuest]

    enum CodingKeys: String, CodingKey {
        case id
        case hostID = "host_id"
        case invitationTitle = "invitation_title"
        case invitationDesc = "invitation_desc"
        case isConfirmed = "is_confirmed"
        case isCancled = "is_cancled"
        case createdAt = "created_at"
        case isDeleted = "is_deleted"
        case host, guests
    }
}

// MARK: - Guest
struct SendGuest: Codable {
    let id: Int
    let username: String
    let isResponse: Bool
}

// MARK: - InvitationDate
struct PlansSendInvitationDate: Codable {
    let id, invitationID: Int
    let date, start, end: String
    let respondent: [Host]

    enum CodingKeys: String, CodingKey {
        case id
        case invitationID = "invitation_id"
        case date, start, end, respondent
    }
}
