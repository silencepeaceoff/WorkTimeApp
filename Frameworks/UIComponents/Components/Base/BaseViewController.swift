//
//  BaseViewController.swift
//  UIComponents
//
//  Created by Dmitrii Tikhomirov on 4/20/23.
//

import UIKit

open class BaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension BaseViewController {
    @objc open func setup() {
        
    }
}
