import Foundation

final class ValidNickname {
    
    static let validNickname = ValidNickname()
    
    private init() {}

    
    func requestPOST(nickname: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        
        var urlComponents = URLComponents(string: APIConstants.validNicknameURL)
        let userNicknameQuery = URLQueryItem(name: "nickname", value: nickname)
        urlComponents?.queryItems = [userNicknameQuery]
        
        guard let requestURL = urlComponents?.url else {
            print("[requestPOST: URL 생성 실패]")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "HEAD"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
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
                completion(.pathErr)
                return
            default:
                return
            }
            
        }
        dataTask.resume()
    }
}
