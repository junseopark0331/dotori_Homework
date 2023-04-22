import Foundation

final class Signup {
    
    static let signup = Signup()
    
    private init() {}

    func requestPOST(nickname: String, id: String, password: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        
        var urlComponents = URLComponents(string: APIConstants.signupURL)
        
        let dicData = ["nickname": nickname, "userId": id, "password" : password] as Dictionary<String, Any>? // 딕셔너리 사용해 json 데이터 만든다
        let jsonData = try! JSONSerialization.data(withJSONObject: dicData!, options: [])
        
        guard let requestURL = urlComponents?.url else {
            print("[requestPOST: URL 생성 실패]")
            return
        }
        
       
        
        var request = URLRequest(url: requestURL)
       
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("[requestPOST: http post 요청 실패]")
                print("fail: ", error?.localizedDescription ?? "")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
          
            print(statusCode)
            
            switch statusCode {
            case 200:
                completion(.success(""))
                return
            case 400:
                completion(.requestErr)
            case 409:
                completion(.pathErr)
                return
            default:
                return
            }
        }
    dataTask.resume()
    }
}

