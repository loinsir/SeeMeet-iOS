import Foundation

// MARK: - HomeDataModel
struct PlansDetailDataModel: Codable {
    let status: Int
    let success: Bool
    let data: PlansDetailListData
}

// MARK: - DataClass
struct PlansDetailListData: Codable {
    let invitation: PlansInvitation
    let invitationDates: [InvitationDate]
}

// MARK: - Invitation
struct PlansInvitation: Codable {
    let id, hostID: Int
    let invitationTitle, invitationDesc: String
    let isConfirmed, isCancled: Bool
    let createdAt: String
    let isDeleted: Bool
    let host: PlansHost
    let guests: [PlansGuest]

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
struct PlansGuest: Codable {
    let id: Int
    let username: String
    let isResponse: Bool
}

// MARK: - Host
struct PlansHost: Codable {
    let id: Int
    let username: String
}

// MARK: - InvitationDate
struct InvitationDate: Codable {
    let id, invitationID: Int
    let date, start, end: String
    let respondent: [PlansHost]

    enum CodingKeys: String, CodingKey {
        case id
        case invitationID = "invitation_id"
        case date, start, end, respondent
    }
}
