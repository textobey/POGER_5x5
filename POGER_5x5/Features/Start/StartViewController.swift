//
//  StartViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class StartViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let logoImage = UIImageView().then {
        $0.image = UIImage(named: "splash_logo_dark")
    }
    
    //*Deprecated. 후에 UILabel 사용시 이것으로 변경
    //let logoWrapperView = UIView().then {
    //    $0.backgroundColor = .clear
    //}
    //
    //let logoTitle = UILabel().then {
    //    $0.text = "5x5\nPOGER"
    //    $0.textColor = .label
    //    $0.font = .systemFont(ofSize: 96, weight: .bold)
    //    $0.textAlignment = .center
    //    $0.numberOfLines = 0
    //}
    
    let nextButton = UIButton.commonButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogoImageView()
    }
    
    private func setupLayout() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(300)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-52)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    private func bind() {
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let levelCheckViewController = LevelCheckViewController()
                owner.navigationController?.pushViewController(levelCheckViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func animateLogoImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 1) {
                self.logoImage.snp.remakeConstraints {
                    $0.top.equalToSuperview().offset(60)
                    $0.centerX.equalToSuperview()
                    $0.size.equalTo(200)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    //LaunchScreen.storyboard 에서는 CustomFont 사용불가
    //private func setAttributedText() {
    //    let attrString = NSMutableAttributedString(string: "5x5\nPOGER")
    //    attrString.addAttributes(
    //        [.font: UIFont.montserrat(size: 48, style: .regular)],
    //        range: (attrString.string as NSString).range(of: "POGER")
    //    )
    //    logoLabel.attributedText = attrString
    //}
}
