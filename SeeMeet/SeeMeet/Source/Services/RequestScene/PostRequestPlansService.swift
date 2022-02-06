import Foundation
import Alamofire

struct RequestPlansParameter {
    var guests: [[String: Any]] = []
    var title: String?
    var contents: String?
    var date: [String] = []
    var start: [String] = []
    var end: [String] = []
    
    func isAnyPropertyNotNil() -> Bool {
        !guests.isEmpty
        && title != nil
        && contents != nil
        && !date.isEmpty
        && !start.isEmpty
        && !end.isEmpty
    }
}

struct PostRequestPlansService {
    
    // MARK: - properties
    
    static let shared = PostRequestPlansService()
    
    private var headers: HTTPHeaders?
    
    var parameterData = RequestPlansParameter()  // 싱글턴 객체로 참조할 수 있게 함
    
    // MARK: - initializer
    
    init() {
        guard let headers = TokenUtils().getAuthorizationHeader(serviceID: "accesstoken") else { return }
        self.headers = headers
    }
    
    // MARK: - methods
    
    func requestPlans(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        guard parameterData.isAnyPropertyNotNil() else { return }
        
        let url = Constants.invitationURL
        
        let requestBody: Parameters = ["guests": parameterData.guests,
                                       "invitationTitle": parameterData.title ?? "",
                                       "invitationDesc": parameterData.contents ?? "",
                                       "date": parameterData.date,
                                       "start": parameterData.start,
                                       "end": parameterData.end]
   
        let request = AF.request(url,
                                 method: .post,
                                 parameters: requestBody,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        
        request.responseData { responseData in
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
    
    func requestPlans(guests: [[String: Any]], title: String, contents: String, date: [String],start: [String], end:[String],
                      completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = Constants.invitationURL
        
        let requestBody: Parameters = ["guests": guests,
                                       "invitationTitle": title,
                                       "invitationDesc": contents,
                                       "date": date,
                                       "start": start,
                                       "end": end]
   
        let request = AF.request(url,
                                 method: .post,
                                 parameters: requestBody,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
        
        request.responseData { responseData in
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

