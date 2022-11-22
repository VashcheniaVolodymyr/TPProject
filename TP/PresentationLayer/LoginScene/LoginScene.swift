//
//  LoginScene.swift
//  TP
//
//  Created by Developer on 15.11.2022.
//

import SwiftUI

struct LoginScene: View {
    
    @State var textLogin: Binding<String> = .constant("")
    
    var body: some View {
        Color.tpDarkGray
            .frame(
                maxWidth: UIScreen.main.bounds.width,
                maxHeight: UIScreen.main.bounds.height
            )
            .overlay(
                VStack(alignment: .leading) {
                    loginImageComponent
                    Color.tpDarkGray
                    VStack(alignment: .leading) {
                        welkomeTextComponents
                            .padding(.bottom, 30)
                        textFieldsComponents
                            .padding(.bottom, 40)
                        buttonsComponents
                            .padding(.bottom, 40)
                    }
                    .padding(.all)
                }.frame(width: UIScreen.main.bounds.width)
                
            )
            .background(Color.tpDarkGray)
    }
    
    private var loginImageComponent: some View {
        ZStack(alignment: .top) {
            Image.rickAndMortyBackIcon
                .resizable()
                .frame(height: 639)
                .padding(.top, -263)
                .scaledToFill()
            Image.rickAndMortyIcon
                .resizable()
                .frame(width: 140, height: 50)
                .padding(.top, 48)
                .scaledToFill()
        }
    }
    
    private var welkomeTextComponents: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Welkome!")
                .bold()
                .foregroundColor(.white)
                .font(.title)
            Text("Create an account to get started.")
                .font(.caption)
                .bold()
                .foregroundColor(Color.tpLigthGray)
        }
    }
    
    private var textFieldsComponents: some View {
        VStack(alignment: .leading, spacing: 25) {
            loginConponent
            passwordConponent
        }
    }
    
    private var buttonsComponents: some View {
        VStack(alignment: .center, spacing: 25) {
            singUpComponent
            singInComponent
        }
    }
    
    private var loginConponent: some View {
        TPIconTextFiled(config: .init(placeholder: "Login", image: .emailIconDisabled, text: textLogin))
    }
    private var passwordConponent: some View {
        TPIconTextFiled(config: .init(placeholder: "Your password", image: .passwordIconInDisabled, text: textLogin))
    }
    
    private var singUpComponent: some View {
        TPButton(config: .init(title: "Sing up", action: nil), style: .deepColorButton)
    }
    
    private var singInComponent: some View {
        HStack {
            Text("or")
                .bold()
                .foregroundColor(.tpLigthGray)
            Text("Sing in")
                .bold()
                .foregroundColor(.white)
        }
    }
    
}
