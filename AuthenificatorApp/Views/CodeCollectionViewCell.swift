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
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var issuerImageView: UIImageView!
    @IBOutlet private weak var issuerName: UILabel!
    @IBOutlet private weak var timerView: TimerView!
    @IBOutlet private weak var remainingTimeLabel: UILabel!
    @IBOutlet private weak var disposableCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.backgroundColor = UIColor.tertiarySystemGroupedBackground.cgColor
        containerView.layer.cornerRadius = 10
    }
    
    func configureUI() {
        disposableCode.font = UIFont.customFont(size: UIFont.Constants.titleSize, weight: .bold)
        issuerName.font = UIFont.customFont(size: UIFont.Constants.titleSize, weight: .bold)
        remainingTimeLabel.font = UIFont.customFont(size: UIFont.Constants.hintSize, weight: .regular)
        remainingTimeLabel.textColor = UIColor.lightBlue
    }
    
    func configureCombine() {
        cn.removeAll()
        
        vm.outSubject
            .map(\.issuer)
            .sink { [weak self] issuerName in
                self?.issuerName.text = issuerName
            }.store(in: &cn)
        
        vm.outSubject
            .map(\.currentPassword)
            .sink { [weak self] currentPassword in
                guard var pass = currentPassword else { return }
                let index = pass.index(pass.startIndex, offsetBy: 3)
                pass.insert(contentsOf: "    ", at: index)
                self?.disposableCode.text = pass
            }.store(in: &cn)
        
        vm.outSubject
            .combineLatest(vm.outTime)
            .map { ($0.0.period, $0.1) }
            .sink { [weak self] period, remainingTime in
                self?.timerView.period = period
                self?.timerView.remainingTime = remainingTime
                self?.remainingTimeLabel.text = String(Int(remainingTime))
                
                DispatchQueue.main.async {
                    self?.timerView.setNeedsDisplay()
                }
            }.store(in: &cn)
    }
    
}
