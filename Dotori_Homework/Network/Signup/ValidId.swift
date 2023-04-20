import Foundation

final class ValidId {
    
    static let validId = ValidId()
    
    private init() {}
    
    
    
    func requestPOST(id: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        
        var urlComponents = URLComponents(string: "https://api.glog.kro.kr/auth/valid-id")
        let userIdQuery = URLQueryItem(name: "userId", value: id)
        urlComponents?.queryItems = [userIdQuery]
        
        guard let requestURL = urlComponents?.url else {
            print("[requestPOST: URL 생성 실패]")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "HEAD"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // 이때의 error는 데이터 통신 자체가 성공, 실패
            
            guard error == nil else {
                print("[requestPOST: http post 요청 실패]")
                print("fail: ", error?.localizedDescription ?? "")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
          
            switch statusCode {
            case 200:
                completion(.success(""))
                return
            case 400:
                completion(.requestErr)
            case 409:
                print("409!!")
                completion(.pathErr)
                return
            default:
                return
            }
            
        }
        dataTask.resume()
    }
    
    
}

