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
    
    let nextButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.label, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 18, style: .bold)
        $0.titleLabel?.textAlignment = .center
        $0.backgroundColor = .tertiarySystemBackground
        $0.layer.cornerRadius = 16
    }
    
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
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28)
            $0.height.equalTo(56)
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
