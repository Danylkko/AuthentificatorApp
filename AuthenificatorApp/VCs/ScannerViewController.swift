//
//  ScannerViewController.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 03.07.2023.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, Storyboarded {
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet private weak var barView: UIView!
    @IBOutlet private weak var barLabel: UILabel!
    @IBOutlet private weak var barDissmissImageButton: UIImageView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var cameraView: UIView!
    
    weak var coordinator: ScannerCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = cameraView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
        
        addQRFrame(at: cameraView.layer.bounds, for: cameraView)
        configureBar()
        configureInfoView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinator?.dismissScanner()
    }
    
    func configureBar() {
        barView.backgroundColor = .heavyGrey
        
        let barTitle = "Scan Code"
        barLabel.text = barTitle
        barLabel.font = UIFont(name: "Poppins-Regular", size: 24)
        
        let image = UIImage(systemName: "xmark.circle.fill")
        barDissmissImageButton.image = image?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        barDissmissImageButton.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissButtonTapped))
        barDissmissImageButton.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissButtonTapped() {
        coordinator?.dismissScanner()
    }
    
    func configureInfoView() {
        infoView.backgroundColor = .black
    }
    
    func addQRFrame(at frame: CGRect, for view: UIView) {
        let sideSize: CGFloat = 155
        let newOrigin = CGPoint(
            x: frame.origin.x + (frame.width - sideSize) / 2,
            y: frame.origin.y + (frame.height - sideSize) / 2
        )
        let newFrame = CGRect(
            origin: newOrigin,
            size: CGSize(width: sideSize, height: sideSize)
        )
        let qrFrameView = QRFrameView(frame: newFrame)
        view.addSubview(qrFrameView)
    }

    func failed() {
        let ac = UIAlertController(
            title: "Scanning not supported",
            message: "Your device does not support scanning a code from an item. Please use a device with a camera.",
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            DispatchQueue.global().async {
                self.captureSession.startRunning()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

        dismiss(animated: true)
    }

    func found(code: String) {
        print(code)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

