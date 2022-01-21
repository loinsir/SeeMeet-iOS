import Foundation

// MARK: - friendsDataModel
struct FriendsDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [FriendsData]
}

// MARK: - Datum
struct FriendsData: Codable {
    let id: Int
    let username, email: String
}
