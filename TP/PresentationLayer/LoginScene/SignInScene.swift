//
//  LoginScene.swift
//  TP
//
//  Created by Developer on 15.11.2022.
//

import SwiftUI
import Combine

protocol SingInSceneVMP: ObservableObject {
    var title: String { get }
    var subTitle: String { get }
    var loginTextFieldConfig: TPIconTextField.Config { get }
    var passwordTextFieldConfig: TPIconTextField.Config { get }
    var singInDeepColorButtonConfig: TPButton.Config { get }
    var singInTextButtonConfig: TPButton.Config { get }
    var emailText: String { get set }
    var passwordText: String { get set }
    var singInButtonTapped: Bool { get set }
}

struct SingInScene<ViewModel: SingInSceneVMP>: View {
    @Namespace private var animation
    @State private var isFlipped = false
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.tpDarkGray)
                .ignoresSafeArea()
            
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
            }
            .onTapGesture {
                hideKeyboard()
            }
            .fullScreenCover(isPresented: $viewModel.singInButtonTapped) {
                CharacterScene(viewModel: CharacterSceneViewModel())
            }
        }
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
                .foregroundColor(.white)
                .font(.gilroyBold)
                .bold()
            Text(viewModel.subTitle)
                .font(.gilroyMedium12)
                .bold()
                .foregroundColor(Color.tpLigthGray)
        }
    }
    
    private var textFieldsComponents: some View {
        VStack(alignment: .leading, spacing: 25) {
            loginComponent
            passwordConponent
        }
    }
    
    private var buttonsComponents: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                if isFlipped {
                    singUpComponent
                        .matchedGeometryEffect(id: "Shape", in: animation)
                    singInComponent
                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                } else {
                    singUpComponent
                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                    singInComponent
                        .matchedGeometryEffect(id: "Shape", in: animation)
                }
            }
        }
    }
    
    private var loginComponent: some View {
        TPIconTextField(text: $viewModel.emailText, style: .login, config: viewModel.loginTextFieldConfig)
    }
    private var passwordConponent: some View {
        TPIconTextField(text: $viewModel.passwordText, style: .password, config: viewModel.passwordTextFieldConfig)
    }
    
    private var singUpComponent: some View {
        TPButton(config: viewModel.singInDeepColorButtonConfig, style: .deepColorButton)
    }
    
    private var singInComponent: some View {
        HStack(alignment: .center, spacing: 8){
            Text("or")
                .font(.gilroyReqular14)
                .foregroundColor(.tpLigthGray)
            
            TPButton(config: viewModel.singInTextButtonConfig, style: .textButton) {
                withAnimation(.linear) {
                    isFlipped.toggle()
                }
            }
        }
        .frame(minWidth: 40, maxWidth: .infinity, minHeight: 48, maxHeight: 48)
    }
}

struct SingInScene_Previews: PreviewProvider {
    static var previews: some View {
       SingInScene(viewModel: SingInSceneViewModel())
    }
}
