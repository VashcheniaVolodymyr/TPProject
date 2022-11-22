//
//  TPButton.swift
//  TP
//
//  Created by Developer on 20.11.2022.
//

import SwiftUI

struct TPButton: View {
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
    
    init(config: Config, style: Style) {
        self.config = config
        self.style = style
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
            .frame(width: 355, height: 48)
            .background(config.action.isNil ? Color.tpPurple : Color.tpLigthGray)
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
            .foregroundColor(.white)
            .bold()
            .frame(width: 60, height: 24)
    }
    
    private func action() {
        guard let action = config.action else { return }
        action()
    }
}
