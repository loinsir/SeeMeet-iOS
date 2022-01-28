
import Foundation

// MARK: - HomeDataModel
struct LastDateDataModel: Codable {
    let status: Int
    let success: Bool
    let data: DateModel
}

// MARK: - DataClass
struct DateModel: Codable {
    let date: String
}
