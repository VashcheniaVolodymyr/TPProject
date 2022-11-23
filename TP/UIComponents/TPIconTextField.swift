//
//  TPIconTextFiled.swift
//  TP
//
//  Created by Developer on 15.11.2022.
//

import SwiftUI
import Foundation

struct TPIconTextField: View {
    typealias IconFrame = (width: CGFloat, height: CGFloat)
    
    struct Config {
        let placeholder: String
        let image: Image
        var text: Binding<String>?
        
        init(placeholder: String, image: Image, text: Binding<String>?) {
            self.placeholder = placeholder
            self.image = image
            self.text = text
        }
        
        static let empty = TPIconTextField.Config(placeholder: "", image: Image(uiImage: .init()), text: .constant(""))
    }
    
    enum Style {
        case login
        case password
    }

    let style: Style
    let config: Config
    
    var body: some View {
        HStack {
            iconComponent
                .padding(16)
                .foregroundColor(.tpPurple)
            textFieldComponent
        }
        .background(Color.tpMidGray)
        .frame(height: 48)
        .cornerRadius(8)
    }
    
    init(style: Style, config: Config) {
        self.style = style
        self.config = config
    }
    
    private var iconComponent: some View {
        config.image
            .resizable()
            .frame(width: getIconFrame().width, height: getIconFrame().height)
            .scaledToFill()
    }
    
    private var textFieldComponent: some View {
        TextField(text: config.text ?? .constant(""), axis: .horizontal, label: {
            placeholterComponent
        })
        .font(.callout)
    }
    
    private var placeholterComponent: some View {
        Text(config.placeholder)
            .foregroundColor(.tpTextMidGray)
            .frame(width: 100, height: 24)
            .font(Font.gilroyMedium14)
    }
}

extension TPIconTextField {
    private func getIconFrame() -> IconFrame {
        var frame: IconFrame = IconFrame(width: 0, height: 0)
        switch style {
        case .password:
            frame = IconFrame(width: 14.5, height: 14.77)
        case .login:
            frame = IconFrame(width: 16, height: 16)
        }
        return frame
    }
}
