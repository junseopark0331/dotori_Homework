import UIKit
import SnapKit
import Then
import QRCode
import PinLayout
import CoreImage.CIFilterBuiltins
import EventSource

final class PaymentViewController: UIViewController {
    
    var menuName: String = ""
    var totalPrice: Int = 0
    var totalQuantity: Int = 0
    var menuNumber: Int = 0
    var connectURL: String = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private let paymentView = UIView().then{
        $0.layer.cornerRadius = 55
        $0.clipsToBounds = true
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowColor = UIColor(rgb: 000000).cgColor
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    private let paymentQRCodeLabel = UILabel().then{
        $0.text = "결제 QR"
        $0.textColor = UIColor(rgb: 0x3C3C3C)
        $0.textAlignment = .center
        $0.font = .Vending(size: 60, family: .bold)
    }
    
    private let qrCodeScanLabel = UILabel().then{
        $0.text = "앱에서 QR코드를 스캔해 주세요"
        $0.textColor = UIColor(rgb: 0x3C3C3C)
        $0.textAlignment = .center
        $0.font = .Vending(size: 35, family: .medium)
    }
    
    private let qrCodeView = UIView().then{
        $0.layer.cornerRadius = 36
        $0.clipsToBounds = true
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowColor = UIColor(rgb: 000000).cgColor
        $0.layer.masksToBounds = false
        $0.backgroundColor = .white
    }
    
    private let cancelPaymentButton = UIButton().then{
        $0.setTitle("결제취소하기", for: .normal)
        $0.setTitleColor(UIColor(rgb: 0xFFFFFF), for: .normal)
        $0.backgroundColor = UIColor(rgb: 0xEC4242)
        $0.titleLabel?.font = .Vending(size: 45, family: .semiBold)
        $0.layer.cornerRadius = 55
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(cancelPaymentButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(paymentView)
        view.addSubview(paymentQRCodeLabel)
        view.addSubview(qrCodeScanLabel)
        view.addSubview(qrCodeView)
        view.addSubview(cancelPaymentButton)
        
        let backBarButtonItem = UIBarButtonItem(title: "전 화면으로", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(rgb: 0x777777)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        makeQRCode()
        setLayout()
        serverSendEvent()
        
    }
    
    func setLayout(){
        self.paymentView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(96)
            $0.height.equalTo(1186)
            $0.leading.trailing.equalToSuperview().inset(86)
        }
        self.paymentQRCodeLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(paymentView).offset(64)
        }
        self.qrCodeScanLabel.snp.makeConstraints{
            $0.top.equalTo(paymentView).offset(152)
            $0.centerX.equalToSuperview()
        }
        self.qrCodeView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(391)
            $0.leading.trailing.equalToSuperview().inset(189)
            $0.height.equalTo(646)
        }
        self.cancelPaymentButton.snp.makeConstraints{
            $0.height.equalTo(108)
            $0.leading.trailing.equalToSuperview().inset(272)
            $0.bottom.equalToSuperview().inset(168)
        }
    }
    
    func makeQRCode(){
//        connectURL = "http://13.125.77.165:3000/send1?price=3000&quantity=3&item=jelly"
        
        connectURL = "http://13.125.77.165:3000/send1?price=\(totalPrice)&quantity=\(totalQuantity)&item=\(menuName)&number=\(menuNumber)"
        guard let encodedStr = connectURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        
        guard let url = URL(string: encodedStr) else {return}
        
        var qrCode = QRCode(url: URL(string: encodedStr)!)
        
        qrCode!.color = UIColor.black // QR 코드 선 색상
        qrCode!.backgroundColor = UIColor.white // QR 코드 배경 색상
        qrCode!.size = CGSize(width: 480, height: 480) // QR 코드 사이즈 정의
        qrCode!.scale = 1.0 // scaling
        qrCode!.inputCorrection = .quartile
        
        let imageView = UIImageView.init(qrCode: qrCode! as QRCode)
        self.view.addSubview(imageView)
        imageView.pin.horizontally().top(30%).width(600).height(600).justify(.center)
    }
    
    func serverSendEvent(){
        let eventSourceURL = "http://13.125.77.165:3000/receive"
        let eventSource = EventSource(request: .init(url: URL(string: eventSourceURL)!))
        eventSource.connect()
        
        Task {
            for await event in eventSource.events {
                switch event {
                case .open:
                    print("성공")
                    print("Connection was opened.")
                case .error(let error):
                    print("에러")
                    print("Received an error:", error.localizedDescription)
                case .message(let message):
                    print("메시지")
                    print("Received a message", message.data ?? "데이터 없음")
                    
                    do {
                        let response = try JSONDecoder().decode(PaymentFinishedData.self, from: message.data!.data(using: .utf8)!)
                        print(response.type)
                        
                        if(response.type == "pay"){
                            print("코인 채굴 완료")
                            paymentFinished()
                        }
                    } catch {

                    }
                case .closed:
                    print("Connection was closed.")
                }
            }
        }
    }
    
    @objc func cancelPaymentButtonTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func paymentFinished(){
        let vc = FinishPaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func paymentFailed(){
        let vc = FailPaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
