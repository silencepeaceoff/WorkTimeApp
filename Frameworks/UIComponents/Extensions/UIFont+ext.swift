//
//  UIFont+ext.swift
//  UIComponents
//
//  Created by Dmitrii Tikhomirov on 6/17/23.
//

import Foundation

extension UIFont {

  static func registerFonts(from bundle: Bundle) {
    let fontUrls = bundle.urls(forResourcesWithExtension: "ttf", subdirectory: nil)!
    fontUrls.forEach { url in
      let fontDataProvider = CGDataProvider(url: url as CFURL)!
      let font = CGFont(fontDataProvider)!

      var error: Unmanaged<CFError>?
      guard CTFontManagerRegisterGraphicsFont(font, &error) else {
        fatalError("Could not register font from url \(url), error: \(error!.takeUnretainedValue ())")
      }
    }
  }

}
