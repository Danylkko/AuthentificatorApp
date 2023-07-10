//
//  ScannerViewController.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 03.07.2023.
//

import AVFoundation
import OneTimePassword
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, Storyboarded, CameraViewControllerDelegate {
    
    func cameraVCDidFoundQR(info: String) {
        
        guard let uri = URL(string: info), let _ = Token(url: uri) else {
            let alert = UIAlertController(title: "An error occured.",
                                          message: "Sorry. The scanned QR code cannot be processed.",
                                          preferredStyle: .alert)
            alert
                .addAction(
                    UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                  style: .default)
                    { _ in
                        self.coordinator?.dismissScanner()
                        NSLog("The \"OK\" alert occured.")
                    }
                )
            present(alert, animated: true, completion: nil)
            return
        }
        
        DataManager.shared.addRecord.send(uri)
        coordinator?.dismissScanner()
    }
    
    
    @IBOutlet private weak var barView: UIView!
    @IBOutlet private weak var barLabel: UILabel!
    @IBOutlet private weak var barDissmissImageButton: UIImageView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var cameraView: UIView!
    
    @IBOutlet private weak var alternativeMethodButton: UIButton!
    @IBOutlet private weak var infoButton: UIButton!
    
    weak var coordinator: ScannerCoordinator?
    var cameraVC: CameraViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraVC?.delegate = self
        configureInfoView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureBar()
        configureCameraView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinator?.dismissScanner()
    }
    
    func configureCameraView() {
        guard let cameraVC = cameraVC else { return }
        cameraVC.view.frame = cameraView.bounds
        cameraView.addSubview(cameraVC.view)
    }
    
    func configureBar() {
        barView.backgroundColor = .heavyGrey
        
        let barTitle = "Scan Code"
        barLabel.text = barTitle
        barLabel.font = UIFont.customFont(
            size: UIFont.Constants.labelSize,
            weight: .regular
        )
        
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
        let altButtonTitle = "  Choose Alternative Method"
            .attributedStringUsingCustomFont(
                size: UIFont.Constants.titleSize,
                weight: .bold
            )
        
        let imageConfig = UIImage.SymbolConfiguration(
            font: .boldSystemFont(ofSize: UIFont.Constants.titleSize),
            scale: .medium
        )
        let image = UIImage(
            systemName: "rectangle.and.pencil.and.ellipsis",
            withConfiguration: imageConfig
        )
        
        
        alternativeMethodButton.setImage(image, for: .normal)
        alternativeMethodButton.setAttributedTitle(altButtonTitle, for: .normal)
        
        let infoButtonTitle = "How to setup 2FA codes"
            .attributedStringUsingCustomFont(
                size: UIFont.Constants.titleSize,
                weight: .light
            )
        infoButton.setAttributedTitle(infoButtonTitle, for: .normal)
    }
}

