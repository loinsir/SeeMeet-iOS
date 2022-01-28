//
//  PostRequestPlansService.swift
//  SeeMeet
//
//  Created by 이유진 on 2022/01/21.
//

import Foundation
import Alamofire

struct PostRequestPlansService {
    
    // MARK: - properties
    
    static let shared = PostRequestPlansService()
    
    private var headers: HTTPHeaders?
    
    // MARK: - initializer
    
    init() {
        guard let headers = TokenUtils().getAuthorizationHeader(serviceID: "accesstoken") else { return }
        self.headers = headers
    }
    
    // MARK: - methods
    
    func requestPlans(guests: [[String: Any]],title: String,contents: String,date: [String],start: [String],end:[String],
                      completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = Constants.invitationURL
        
        let requestBody: Parameters = ["guests": guests,
                                       "invitationTitle": title,
                                       "invitationDesc": contents,
                                       "date": date,
                                       "start": start,
                                       "end": end]
        
//        dump(requestBody)
   
        let request = AF.request(url,
                                 method: .post,
                                 parameters: requestBody,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        
        request.responseData { responseData in
            dump(responseData)
            switch responseData.result {
            case .success:
                if let statusCode = responseData.response?.statusCode,
                   let value = responseData.value {
                    let networkResult = judgeStatus(by: statusCode, value)
                    completion(networkResult)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200, 400, 404: return isValidDecodableData(data: data)
        case 500: return .serverErr
        default: return.networkFail
        }
    }
    
    private func isValidDecodableData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(PlanRequestData.self, from: data) else { return .pathErr }
        if decodedData.status == 200 {
            return .success(decodedData)
        } else {
            return .requestErr(decodedData)
        }
    }
    
    
    
}
