import Foundation

struct Constants {
    //baseURL
    static let baseURL = "https://asia-northeast3-seemeet-700c2.cloudfunctions.net/api"
    
    //auth관련
    static let registerURL = baseURL + "/auth/register"
    static let loginURL = baseURL + "/auth/login"
    static let withdrawURL = baseURL + "/auth/userDelete"
    
    //home관련
    static let homeURL = baseURL + "/plan/comeplan"
    static let lastURL = baseURL + "/plan/lastplan"
    
    //친구 관련
    static let friendsListURL = baseURL + "/friend/list"
    
    //약속 관련
    static let plansListURL = baseURL + "/invitation/list"
    static let plansDetailURL = baseURL + "/invitation/"
}
