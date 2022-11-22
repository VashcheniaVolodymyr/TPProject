//
//  LoginScene.swift
//  TP
//
//  Created by Developer on 15.11.2022.
//

import SwiftUI

protocol SingInSceneVMP: ObservableObject {
    var title: String { get }
    var subTitle: String { get }
    var loginTextFieldConfig: TPIconTextFiled.Config { get }
    var passwordTextFieldConfig: TPIconTextFiled.Config { get }
    var singInDeepColorButtonConfig: TPButton.Config { get }
    var singInTextButtonConfig: TPButton.Config { get }
}

struct SingInScene<ViewModel: SingInSceneVMP>: View {
    
    @ObservedObject var viewModel: ViewModel
    
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
            Text(viewModel.title)
                .bold()
                .foregroundColor(.white)
                .font(.title)
            Text(viewModel.subTitle)
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
        TPIconTextFiled(config: viewModel.loginTextFieldConfig)
    }
    private var passwordConponent: some View {
        TPIconTextFiled(config: viewModel.passwordTextFieldConfig)
    }
    
    private var singUpComponent: some View {
        TPButton(config: viewModel.singInDeepColorButtonConfig, style: .deepColorButton)
    }
    
    private var singInComponent: some View {
        HStack {
            Text("or")
                .bold()
                .foregroundColor(.tpLigthGray)
            TPButton(config: viewModel.singInTextButtonConfig, style: .textButton)
        }
    }
    
}
