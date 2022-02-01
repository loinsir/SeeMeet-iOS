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
    
   init(id: Int, username: String, email: String){
        self.id = id
        self.username = username
        self.email = email
    }
    init(){//Codable 초기화.. 이거 마자..?흠,,,,이렇게하니까 from:Decoder 채우라는 오류는 안나옴
        self.id = 0
        self.username = ""
        self.email = ""
    }
    
}

extension FriendsData: Equatable {
    static func == (lhs: FriendsData, rhs: FriendsData) -> Bool {
        return lhs.id == rhs.id
    }
}

extension FriendsData: Comparable {//Comparable 이게 최선은 아닐듯 ..
    static func < (lhs: FriendsData, rhs: FriendsData) -> Bool {
        return lhs.username<lhs.username
    }
    
    static func <= (lhs: FriendsData, rhs: FriendsData) -> Bool {
        return lhs.username<=lhs.username
    }
    
    static func > (lhs: FriendsData, rhs: FriendsData) -> Bool {
        return lhs.username>lhs.username
    }
    
    static func >= (lhs: FriendsData, rhs: FriendsData) -> Bool {
        return lhs.username>=lhs.username
    }
    
    
}

