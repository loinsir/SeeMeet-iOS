
import Foundation

// MARK: - PlansDetailDataModel
struct PlansDetailDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: PlansDetailData
}

// MARK: - DataClass
struct PlansDetailData: Codable {
    let isResponse: Bool
    let invitation: PlansInvitation
    let invitationDates: [PlansInvitationDate]
    let newGuests: [PlansGuest]
}

// MARK: - Guest
struct PlansGuest: Codable {
    let id: Int
    let username: String
}

// MARK: - Invitation
struct PlansInvitation: Codable {
    let id, hostID: Int
        let invitationTitle, invitationDesc: String
        let isConfirmed, isCancled: Bool
        let createdAt: String
        let isDeleted: Bool
        let host: Host

        enum CodingKeys: String, CodingKey {
            case id
            case hostID = "host_id"
            case invitationTitle = "invitation_title"
            case invitationDesc = "invitation_desc"
            case isConfirmed = "is_confirmed"
            case isCancled = "is_cancled"
            case createdAt = "created_at"
            case isDeleted = "is_deleted"
            case host
        }
}

// MARK: - InvitationDate
struct PlansInvitationDate: Codable {
    let id, invitationID: Int
    let date, start, end: String
    let isSelected: Bool

    enum CodingKeys: String, CodingKey {
            case id
            case invitationID = "invitationId"
            case date, start, end, isSelected
        }
}
