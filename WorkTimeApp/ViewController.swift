//
//  ViewController.swift
//  WorkTimeApp
//
//  Created by Dmitrii Tikhomirov on 4/20/23.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    private let button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
}

