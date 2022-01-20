import Foundation

// MARK: - PlanDetailResponseModel
struct PlanDetailResponseModel: Codable {
    let status: Int
    let success: Bool
    let data: PlanDetailData
}

// MARK: - PlanDetailData
struct PlanDetailData: Codable {
    let planid, invitationid: Int
    let invitationTitle, invitationDesc, date, start: String
    let end: String
    let hostID: Int
    let impossible, possible: [PossibleUser]

    enum CodingKeys: String, CodingKey {
        case planid, invitationid, invitationTitle, invitationDesc, date, start, end
        case hostID = "hostId"
        case impossible, possible
    }
}

// MARK: - PossibleUser
struct PossibleUser: Codable {
    let userID: Int
    let username: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username
    }
}
