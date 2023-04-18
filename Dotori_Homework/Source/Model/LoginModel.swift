import Foundation


struct LoginResponse: Codable{
    
    let accessToken: String
    let refreshToken: String
    let expiredAt: Date
}

