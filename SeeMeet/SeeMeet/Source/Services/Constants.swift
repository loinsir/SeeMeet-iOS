import Foundation

struct Constants {
    //baseURL
    static let baseURL = "https://asia-northeast3-seemeet-700c2.cloudfunctions.net/api"
    
    //auth관련
    static let registerURL = baseURL + "/auth/register"
    static let loginURL = baseURL + "/auth/login"
    static let withdrawURL = baseURL + "/auth/userDelete"
}
