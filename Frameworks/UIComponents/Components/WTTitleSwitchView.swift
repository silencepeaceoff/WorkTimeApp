//
//  WTTitleSwitchView.swift
//  UIComponents
//
//  Created by Dmitrii Tikhomirov on 4/21/23.
//

import UIKit
import SnapKit

extension WTTitleSwitchView {
    public enum ActivityState {
        case left
        case right
    }
}

open class WTTitleSwitchView: BaseView {
    
    private let leftButton = UIButton()
    private let buttonSeperatorView = UILabel()
    private let rightButton = UIButton()
    
    private let animationTimeInterval: TimeInterval = 0.4
    
    public var state = ActivityState.left {
        didSet {
            animateStateSetting()
        }
    }
    
    public var titles: (leftTitle: String, rightTitle: String)? = nil {
        didSet {
            leftButton.setTitle(titles?.leftTitle, for: .normal)
            rightButton.setTitle(titles?.rightTitle, for: .normal)
        }
    }
    
    override func setup() {
        super.setup()
        
        setupLeftButton()
        setupButtonSeperatorView()
        setupRightButton()
    }
}

//MARK: - Setup UI
private extension WTTitleSwitchView {
    
    func setupLeftButton() {
        addSubview(leftButton)
        
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonHandler), for: .touchUpInside)
        
        leftButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalToSuperview()
        }
    }
    
    func setupButtonSeperatorView() {
        addSubview(buttonSeperatorView)
        
        buttonSeperatorView.text = "/"
        
        buttonSeperatorView.snp.makeConstraints {
            $0.centerY.equalTo(leftButton)
            $0.leading.equalTo(leftButton.snp.trailing).offset(5)
        }
    }
    
    func setupRightButton() {
        addSubview(rightButton)
        
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonHandler), for: .touchUpInside)
        rightButton.alpha = 0.3
        
        rightButton.snp.makeConstraints {
            $0.leading.equalTo(buttonSeperatorView.snp.trailing).offset(5)
            $0.verticalEdges.trailing.equalToSuperview()
        }
    }
}

public extension WTTitleSwitchView {
    @IBAction func leftButtonHandler() {
        if state == .right {
            state = .left
        }
    }
    
    @IBAction func rightButtonHandler() {
        if state == .left {
            state = .right
        }
    }
}

private extension WTTitleSwitchView {
    func animateStateSetting() {
        let activeButton = state == .left ? rightButton : leftButton
        let inactiveButton = state == .left ? leftButton : rightButton
        
        UIView.animate(withDuration: animationTimeInterval / 2) {
            activeButton.alpha = 0.3
            self.buttonSeperatorView.alpha = 0.3
        } completion: { _ in
            UIView.animate(withDuration: self.animationTimeInterval) {
                inactiveButton.snp.remakeConstraints {
                    $0.leading.verticalEdges.equalToSuperview()
                }
                
                self.buttonSeperatorView.snp.remakeConstraints {
                    $0.centerY.equalTo(inactiveButton)
                    $0.leading.equalTo(inactiveButton.snp.trailing).offset(5)
                }
                
                activeButton.snp.remakeConstraints {
                    $0.leading.equalTo(self.buttonSeperatorView.snp.trailing).offset(5)
                    $0.verticalEdges.trailing.equalToSuperview()
                }
                self.layoutIfNeeded()
                
            } completion: { _ in
                UIView.animate(withDuration: self.animationTimeInterval / 2) {
                    self.buttonSeperatorView.alpha = 1
                    inactiveButton.alpha = 1
                }
            }
        }
    }
}
