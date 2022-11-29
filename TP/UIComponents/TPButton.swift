//
//  TPButton.swift
//  TP
//
//  Created by Developer on 20.11.2022.
//

import SwiftUI

struct TPButton: View {
    private var tapButtonAction: VoidHandler?
    struct Config {
        let title: String
        let action: VoidHandler?
        var image: UIImage?
        
        init(title: String, action: VoidHandler?) {
            self.title = title
            self.action = action
        }
        
        init(title: String, action: VoidHandler?, image: UIImage) {
            self.init(title: title, action: action)
            self.image = image
        }
        
        static let empty: TPButton.Config = .init(title: "", action: nil)
    }
    
    enum Style {
        case deepColorButton
        case textButton
    }

    let config: Config
    let style: Style
    
    init(config: Config, style: Style, buttonTapped: VoidHandler? = nil) {
        self.config = config
        self.style = style
        self.tapButtonAction = buttonTapped
    }
    
    var body: some View {
        switch style {
        case .deepColorButton: deepButtonView
        case .textButton: textButtonView
        }
    }
    
    private var baseButton: some View {
        Button(action: action, label: {
            HStack {
                if !config.image.isNil {
                    iconComponent
                }
                textComponent
            }
        })
    }
    
    private var deepButtonView: some View {
        baseButton
            .frame(minWidth: 40, maxWidth: .infinity, minHeight: 48, maxHeight: 48)
            .background(config.action.isNil ? Color.tpPurple : Color.tpPurpleLigth)
            .cornerRadius(8)
    }
    
    private var textButtonView: some View {
        baseButton
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
    private var iconComponent: some View {
        Image(uiImage: config.image ?? UIImage())
            .frame(width: 16.5, height: 14.5)
    }
    
    private var textComponent: some View {
        Text(config.title)
            .foregroundColor(getForegroundColor())
            .frame(height: 24)
            .font(.gilroyMedium14)
            .bold()
            .onTapGesture {
                tapAction()
                action()
            }
    }
    
    private func action() {
        guard let action = config.action else { return }
        action()
    }
    
    private func tapAction() {
        guard let action = tapButtonAction else { return }
        action()
    }
    
    private func getForegroundColor() -> Color {
        switch style {
        case .deepColorButton:
            return config.action.isNil ? Color.tpTextMidGray : Color.white
        case .textButton:
            return Color.white
        }
    }
}
