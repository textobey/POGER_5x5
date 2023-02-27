//
//  ActivityIndicator.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/27.
//

import UIKit
import SnapKit

struct ActivityIndicator {
    
    let superview: UIView
    
    let viewForActivityIndicator = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .tertiarySystemBackground
    }
    
    let backgroundView = UIView().then {
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .clear
    }
    
    let activityIndicatorView = UIActivityIndicatorView().then {
        $0.color = .label
        $0.style = .large
        $0.hidesWhenStopped = true
        
    }
    
    let loadingTextLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .callout)
    }
    
    func showActivityIndicator(text: String) {
        loadingTextLabel.text = text
        
        superview.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        backgroundView.addSubview(viewForActivityIndicator)
        viewForActivityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        viewForActivityIndicator.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-12)
        }
        
        viewForActivityIndicator.addSubview(loadingTextLabel)
        loadingTextLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicatorView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        [loadingTextLabel, activityIndicatorView, viewForActivityIndicator, backgroundView].forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        activityIndicatorView.stopAnimating()
    }
}
