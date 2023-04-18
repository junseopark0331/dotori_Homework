import Foundation

final class ValidId{
    
    static let validId = ValidId()
    
    private init() {}
    
    func requestPOST(id: String) {
        
        print(id)
        
        // [URL 지정 및 파라미터 값 지정 실시]
        var urlComponents = URLComponents(string: "https://api.glog.kro.kr/auth/valid-id?=userId=\(id)")
        
        let userIdQuery = URLQueryItem(name: "userId", value: id)

        urlComponents?.queryItems?.append(userIdQuery)
        
        
        // [http 통신 타입 및 헤더 지정 실시]
        var requestURL = URLRequest(url: (urlComponents?.url)!)
        requestURL.httpMethod = "HEAD"
        
//        requestURL.addValue("application/json", forHTTPHeaderField: "userId")
//        requestURL.addValue(id, forHTTPHeaderField: "userId")
        
        // [http 요쳥을 위한 URLSessionDataTask 생성]
        print("")
        print("====================================")
        print("[requestPOST : http post 요청 실시]")
        print("url : ", requestURL)
        print("====================================")
        print("")
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode)
            else{return}

            print(statusCode)
            
//
//
//            // [error가 존재하면 종료]
//            guard error == nil else {
//                print("")
//                print("====================================")
//                print("[requestPOST : http post 요청 실패]")
//                print("fail : ", error?.localizedDescription ?? "")
//                print("====================================")
//                print("")
//                return
//            }
            
//            // [status 코드 체크 실시]
//            let successsRange = 200..<300
//
//            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
//            else {
//                print("")
//                print("====================================")
//                print("[requestPOST : http post 요청 에러]")
//                print("error : ", (response as? HTTPURLResponse)?.statusCode ?? 0)
//                print("msg : ", (response as? HTTPURLResponse)?.description ?? "")
//                print("====================================")
//                print("")
//                return
//            }
            
            
            
//            // [response header cookies 데이터 확인]
//            let cookies = HTTPCookie.cookies(withResponseHeaderFields: (response as? HTTPURLResponse)?.allHeaderFields as! [String : String], for: (urlComponents?.url)!)
//            print("")
//            print("====================================")
//            print("[requestPOST : http post 요청 성공]")
//            print("response header cookies : ", cookies)
//            print("====================================")
//            print("")
//            
//            // [response 데이터 획득, utf8인코딩을 통해 string형태로 변환]
//            let resultCode = (response as? HTTPURLResponse)?.statusCode ?? 0
//            let resultLen = data! // 데이터 길이
//            let resultString = String(data: resultLen, encoding: .utf8) ?? "" // 응답 메시지
//            print("")
//            print("====================================")
//            print("[requestPOST : http post 요청 성공]")
//            print("resultCode : ", resultCode)
//            print("resultLen : ", resultLen)
//            print("resultString : ", resultString)
//            print("====================================")
//            print("")
        }
        // network 통신 실행
        dataTask.resume()
    }
    
    
    
}

