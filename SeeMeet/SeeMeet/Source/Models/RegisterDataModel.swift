import Foundation

// MARK: - RegisterModel
struct RegisterDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: RegisterData?
}

// MARK: - DataClass
struct RegisterData: Codable {
    let user: RegisterUser
    let accesstoken: String
}

// MARK: - User
struct RegisterUser: Codable {
    let id: Int
    let email, idFirebase, username: String
    let isNoticed: Bool
    let createdAt, updatedAt: String
    let isDeleted: Bool
}
