//
//  Font+Extension.swift
//  TP
//
//  Created by Developer on 23.11.2022.
//

import SwiftUI
extension Font {
    static let gilroyMedium12 = Font.generatingFont(name: "Gilroy-Medium", size: 12)
    static let gilroyMedium14 = Font.generatingFont(name: "Gilroy-Medium", size: 14)
    static let gilroyBold = Font.generatingFont(name: "Gilroy-Bold", size: 24)
    static let gilroyReqular14 = Font.generatingFont(name: "Gilroy-Regular", size: 14)
}

extension Font {
    static func generatingFont(name: String, size: CGFloat) -> Font {
        let ctFont = CTFontCreateWithName(name as CFString, size, nil)
        return .init(ctFont)
    }
}
