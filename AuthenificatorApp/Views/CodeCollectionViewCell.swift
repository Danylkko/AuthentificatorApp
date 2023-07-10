//
//  CodeCollectionViewCell.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 03.07.2023.
//

import UIKit
import Combine

class CodeCollectionViewCell: UICollectionViewCell {
    
    public static let reuseId = "CodeCellId"
    let vm = CodeCellViewModel()
    private var cn = Set<AnyCancellable>()
    
    @IBOutlet private weak var issuerImageView: UIImageView!
    @IBOutlet private weak var issuerName: UILabel!
    @IBOutlet private weak var timerView: TimerView!
    @IBOutlet private weak var remainingTimeLabel: UILabel!
    @IBOutlet private weak var disposableCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI() {
        remainingTimeLabel.textColor = .white
    }
    
    func configureCombine() {
        vm.outSubject
            .map(\.issuer)
            .sink { [weak self] issuerName in
                self?.issuerName.text = issuerName
            }.store(in: &cn)
        
        vm.outSubject
            .map(\.currentPassword)
            .sink { [weak self] currentPassword in
                self?.disposableCode.text = currentPassword
            }.store(in: &cn)
        
        vm.outSubject
            .combineLatest(vm.outTime)
            .map { ($0.0.period, $0.1) }
            .sink { [weak self] period, remainingTime in
                self?.timerView.period = period
                self?.timerView.remainingTime = remainingTime
                DispatchQueue.main.async {
                    self?.timerView.setNeedsDisplay()
                }
                self?.remainingTimeLabel.text = String(Int(remainingTime))
            }.store(in: &cn)
    }
    
}
