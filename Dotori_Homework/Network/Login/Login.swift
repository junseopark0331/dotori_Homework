import Foundation
import Alamofire

final class Login {
    
    static let shared = Login()
    
    private init() {}
    
    func login(id: String, password: String, completion: @escaping(NetworkResult<Any>) -> Void)
    {
        let url = APIConstants.loginURL //통신할 API 주소
        
        //HTTP Headers : 요청 헤더
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        //요청 바디
        let body : Parameters = [
            "userId" : id,
            "password" : password
        ]
        
        //요청서 //Request 생성
        //통신할 주소, HTTP메소드, 요청방식, 인코딩방식, 요청헤더
        let dataRequest = AF.request(url,
                                    method: .post,
                                    parameters: body,
                                    encoding: JSONEncoding.default,
                                    headers: header)
                                    
        //request 시작 ,responseData를 호출하면서 데이터 통신 시작
        dataRequest.responseData{
            response in //데이터 통신의 결과가 response에 담기게 된다
            switch response.result {
            case .success: //데이터 통신이 성공한 경우에
                guard let statusCode = response.response?.statusCode else {return}
                print(statusCode)
                guard let value = response.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
            switch statusCode {
            case 200: return isVaildData(data: data)
            case 400, 404 : return .requestErr
            default : return .networkFail
            }
        }

    //통신이 성공하고 원하는 데이터가 올바르게 들어왔을때 처리하는 함수
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        
//        dump(String(data: data, encoding: .utf8))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let decoder = JSONDecoder() //서버에서 준 데이터를 Codable을 채택
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let decodedData = try? decoder.decode(LoginResponse.self, from: data)
        //데이터가 변환이 되게끔 Response 모델 구조체로 데이터를 변환해서 넣고, 그 데이터를 NetworkResult Success 파라미터로 전달
                
        else { return .pathErr }
        
        dump(decodedData)
        
        return .success(decodedData as Any)
    }
        
}
    
