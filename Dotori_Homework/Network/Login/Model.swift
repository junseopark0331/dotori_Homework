enum NetworkResult<T>{
    case success(T) //서버통시성공
    case requestErr //요청에러가발생
    case pathErr //경로에러
    case serverErr //서버의내부에러
    case networkFail //네트워크연결실패
}

