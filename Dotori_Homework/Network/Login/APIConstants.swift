import Foundation

struct APIConstants {
    
    // MARK: - BaseURL
    static let baseURL = "https://api.glog.kro.kr/auth"
    
    // MARK: - FeatureURL
    // loginURL = "https://api.glog.kro.kr/signin"
    static let loginURL = baseURL + "/signin"
    
    // signupURL = "https://api.glog.kro.kr/signup"
    static let signupURL = baseURL + "/signup"
    
    // validIdURL = "https://api.glog.kro.kr/valid-id"
    static let validIdURL = baseURL + "/valid-id"
    
    // validNicknameURL = "https://api.glog.kro.kr/valid-name"
    static let validNicknameURL = baseURL + "/valid-name"
}
