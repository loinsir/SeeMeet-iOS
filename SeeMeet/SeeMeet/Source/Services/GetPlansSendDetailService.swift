import Alamofire
import Foundation

struct GetPlansSendDetailDataService
{
    static let shared = GetPlansSendDetailDataService()
    func getSendDetail(plansId: String, completion : @escaping (NetworkResult<Any>) -> Void)
    {
        // completion 클로저를 @escaping closure로 정의합니다.
        var URL = Constants.plansDetailURL + plansId
        print(URL)
        let tc = TokenUtils()
        let header : HTTPHeaders = tc.getAuthorizationHeader(serviceID: "accesstoken") ?? ["Content-Type": "application/json"]
        print(header)

        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)

        dataRequest.responseData { dataResponse in
//            dump(dataResponse)
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)

            case .failure: completion(.pathErr)
                print("실패 사유")
            }
        }
                                            
    }
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(PlansSendDetailDataModel.self, from: data)
        else {return .pathErr}
        
        return .success(decodedData)

    }
    
}