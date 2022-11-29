//
//  TPIconTextFiled.swift
//  TP
//
//  Created by Developer on 15.11.2022.
//

import SwiftUI

struct TPIconTextField: View {
    typealias IconFrame = (width: CGFloat, height: CGFloat)
    typealias ImageSet = (editing: Image, normal: Image)
    
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    struct Config {
        let placeholder: String
        let imageSet: ImageSet
        
        init(placeholder: String, imageSet: ImageSet) {
            self.placeholder = placeholder
            self.imageSet = imageSet
        }
        
        static let empty = TPIconTextField.Config(placeholder: "", imageSet: (Image(uiImage: .init()), Image(uiImage: .init())))
    }
    
    enum StateTextField {
        case valid
        case invalid
    }
    
    enum Style {
        case login
        case password
    }

    let style: Style
    let config: Config
    
    var body: some View {
        textFieldView
    }
    
    init(text: Binding<String>, style: Style, config: Config) {
        self.style = style
        self.config = config
        self._text = text
    }
    
    private var textFieldView: some View {
        HStack {
            iconComponent
                .padding(16)
            switch style {
            case .password: secureFieldComponent
            case .login: textFieldComponent
            }
        }
        .foregroundColor(.white)
        .background(Color.tpMidGray)
        .frame(height: 48)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(getColorBorder(), lineWidth: 1)
        )
    }
    
    private var iconComponent: some View {
        imageView
            .resizable()
            .frame(width: getIconFrame().width, height: getIconFrame().height)
            .scaledToFill()
    }
    
    private var imageView: Image {
        if !isFocused && text.isNotEmpty {
           return config.imageSet.editing
        } else {
           return isFocused ? config.imageSet.editing : config.imageSet.normal
        }
    }
    
    private var textFieldComponent: some View {
        TextField(config.placeholder, text: self.$text)
        .focused($isFocused)
        .font(Font.gilroyMedium14)
        .bold()
    }
    
    private var secureFieldComponent: some View {
        SecureField(config.placeholder, text: self.$text)
        .focused($isFocused)
        .font(Font.gilroyMedium14)
        .bold()
    }
    
    private var placeholterComponent: some View {
        Text(config.placeholder)
            .foregroundColor(.tpLigthGray)
            .frame(width: 100, height: 24)
            .font(Font.gilroyMedium14)
            .bold()
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
    
    private func getColorBorder() -> Color {
        if !isFocused && text.isNotEmpty { return Color.tpMidGray }
        return isFocused ? Color.tpPurpleLigth : Color.tpMidGray
    }
}
