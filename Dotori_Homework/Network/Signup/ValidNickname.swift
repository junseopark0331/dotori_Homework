//import Foundation
//
//final class ValidNickname {
//
//    static let validNickname = ValidNickname()
//
//    private init() {}
//
//
//
//    func requestPOST(id: String, completion: @escaping (Result<String, Error>) -> Void) {
//
//        var urlComponents = URLComponents(string: "https://api.glog.kro.kr/auth/valid-name")
//        let userIdQuery = URLQueryItem(name: "nickname", value: nickname)
//        urlComponents?.queryItems = [userIdQuery]
//
//        guard let requestURL = urlComponents?.url else {
//            print("[requestPOST: URL 생성 실패]")
//            return
//        }
//
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = "HEAD"
//
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard error == nil else {
//                print("[requestPOST: http post 요청 실패]")
//                print("fail: ", error?.localizedDescription ?? "")
//                return
//            }
//
//            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
//
//            let networkResult = self.judgeStatus(by: statusCode)
//
//            // 데이터 처리 로직 추가
//
//            switch networkResult {
//            case .success:
//                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
//
//
//                guard let networkResult = self.judgeStatus(by: statusCode) else{return}
//
//                print(statusCode)
//
////                completion(networkResult)
////a
//            case .requestErr:
//                // 에러인 경우
//                completion(.failure(NSError(domain: "Network Error", code: 0, userInfo: nil)))
//            case .pathErr:
//                return
//            case .serverErr:
//                return
//            }
//
//        }
//        dataTask.resume()
//    }
//
//    private func judgeStatus(by statusCode: Int) -> NetworkResult<Any> {
//        switch statusCode {
//        case 200:
//            print("statusCode :  \(statusCode)")
//            return .success("")
//        case 400, 409:
//            return .requestErr
//        default:
//            return .networkFail
//        }
//    }
//}
//
//
