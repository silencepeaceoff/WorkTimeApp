//
//  Bundle+ext.swift
//  UIComponents
//
//  Created by Dmitrii Tikhomirov on 6/17/23.
//

import Foundation

class BundleHandler {}

extension Bundle {
  static let uiComponents = Bundle(for: BundleHandler.self)
}
