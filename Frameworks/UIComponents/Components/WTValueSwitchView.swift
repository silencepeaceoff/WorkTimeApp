//
//  WTTitleSwitchView.swift
//  UIComponents
//
//  Created by Dmitrii Tikhomirov on 4/21/23.
//

import UIKit
import SnapKit

extension WTValueSwitchView {
  public enum ActivityState {
    case left
    case right

    mutating func toggle() {
      self = self == .left ? .right : .left
    }
  }
}

open class WTValueSwitchView: BaseView {

  private let firstLabel = UILabel()
  private let separatorView = UILabel()
  private let secondLabel = UILabel()
  private let loginButton = UIButton()

  private let animationTimeInterval: TimeInterval = 0.4
  private var animationPoint: CGFloat = 0
  private var animationTimer = Timer()

  public var state = ActivityState.left {
    didSet {
      animateStateSetting()
    }
  }

  public var titles: (firstTitle: String, secondTitle: String)? = nil {
    didSet {
      firstLabel.text = titles?.firstTitle
      secondLabel.text = titles?.secondTitle
    }
  }

  override func setup() {
    super.setup()

    UIFont.registerFonts(from: Bundle.uiComponents)

    setupSeperatorView()
    setupFirstLabel()
    setupSecondLabel()
    setupLoginButton()
  }
}

//MARK: - Setup UI
private extension WTValueSwitchView {

  func setupSeperatorView() {
    addSubview(separatorView)

    separatorView.text = "/"
    separatorView.font = WTFont.robotoMedium(size: 30)
    separatorView.textColor = WTColor.title_active()

    separatorView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
    }
  }

  func setupFirstLabel() {
    addSubview(firstLabel)

    firstLabel.font = WTFont.robotoMedium(size: 30)
    firstLabel.layoutMargins.bottom = 0
    firstLabel.textColor = WTColor.title_active()

    firstLabel.snp.makeConstraints {
      $0.bottom.leading.equalToSuperview()
      $0.trailing.equalTo(separatorView.snp.leading).offset(-10)
    }
  }

  func setupSecondLabel() {
    addSubview(secondLabel)

    secondLabel.font = WTFont.robotoRegular(size: 20)
    secondLabel.layoutMargins.bottom = 0
    secondLabel.textColor = WTColor.title_inactive()

    secondLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.leading.equalTo(separatorView.snp.trailing).offset(10)
      $0.bottom.equalToSuperview().inset(2.5)
    }
  }

  func setupLoginButton() {
    addSubview(loginButton)

    loginButton.setTitleColor(.black, for: .normal)
    loginButton.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)

    loginButton.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

}

public extension WTValueSwitchView {
  @IBAction func buttonHandler() {
    state.toggle()
  }
}

private extension WTValueSwitchView {
  func animateStateSetting() {
    let activeLabel = state == .left ? secondLabel : firstLabel
    let inactiveLabel = state == .left ? firstLabel : secondLabel

    UIView.animate(withDuration: animationTimeInterval / 4) {
      self.separatorView.alpha = 0.1
    } completion: { _ in
      UIView.animate(withDuration: self.animationTimeInterval / 4,
                     delay: self.animationTimeInterval / 2) {
        self.separatorView.alpha = 1
      }
    }

    UIView.animate(withDuration: animationTimeInterval) {
      activeLabel.textColor = WTColor.title_inactive()
      inactiveLabel.textColor = WTColor.title_active()


      UIView.animate(withDuration: self.animationTimeInterval) {
        inactiveLabel.snp.remakeConstraints {
          $0.leading.bottom.equalToSuperview()
          $0.trailing.equalTo(self.separatorView.snp.leading).offset(-10)
        }

        activeLabel.snp.remakeConstraints {
          $0.trailing.equalToSuperview()
          $0.leading.equalTo(self.separatorView.snp.trailing).offset(10)
          $0.bottom.equalToSuperview().inset(2.5)
        }

        self.layoutIfNeeded()
      }

      self.animationTimer.invalidate()
      self.animationTimer = Timer.scheduledTimer(withTimeInterval: self.animationTimeInterval / 25,
                                                 repeats: true,
                                                 block: { timer in
        if self.animationPoint < 10 {
          self.animationPoint += 0.4

          let inactiveSize = 20 + self.animationPoint
          inactiveLabel.font = inactiveSize > 25
          ? R.font.robotoMedium(size: inactiveSize)
          : R.font.robotoRegular(size: inactiveSize)

          let activeSize = 30 - self.animationPoint
          activeLabel.font = activeSize < 25
          ? R.font.robotoRegular(size: activeSize)
          : R.font.robotoMedium(size: activeSize)

        } else {
          timer.invalidate()
          self.animationPoint = 0
        }
      })
    }
  }
}
