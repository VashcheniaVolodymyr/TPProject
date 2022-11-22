//
//  TPIconTextFiled.swift
//  TP
//
//  Created by Developer on 15.11.2022.
//

import SwiftUI

struct TPIconTextFiled: View {
    struct Config {
        let placeholder: String
        let image: Image
        var text: Binding<String>
        
        init(placeholder: String, image: Image, text: Binding<String>) {
            self.placeholder = placeholder
            self.image = image
            self.text = text
        }
    }

    
    let config: Config
    
    var body: some View {
        HStack {
            iconComponent
                .padding(16)
                .foregroundColor(.tpPurple)
            textFiledComponent
        }
        .background(Color.tpMidGray)
        .frame(height: 48)
        .cornerRadius(8)
    }
    
    
    private var iconComponent: some View {
        config.image
            .resizable()
            .frame(width: 16, height: 16)
            .bold()
            .foregroundColor(.tpPurple)
            .scaledToFill()
    }
    
    private var textFiledComponent: some View {
        TextField(text: config.text, axis: .horizontal, label: {
            placeholterComponent
        })
        .font(.callout)
    }
    
    private var placeholterComponent: some View {
        Text(config.placeholder)
            .foregroundColor(.tpLigthGray)
            .frame(width: 100, height: 24)
    }
}
