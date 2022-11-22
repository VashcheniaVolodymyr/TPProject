//
//  LoginSceneViewModel.swift
//  TP
//
//  Created by Developer on 22.11.2022.
//

import Foundation
import Combine

enum SingInState {
    case signIn
    case signUp
}

final class SingInSceneViewModel: SingInSceneVMP {
    
    typealias Constants = TP.SingInScene.Constants
    // MARK: Public proporties
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var loginTextFieldConfig: TPIconTextFiled.Config = .empty
    @Published var passwordTextFieldConfig: TPIconTextFiled.Config = .empty
    @Published var singInDeepColorButtonConfig: TPButton.Config = .empty
    @Published var singInTextButtonConfig: TPButton.Config = .empty
    
    @Published var singInState: SingInState = .signUp
    
    // MARK: Private proporties
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: Initialisations
    init() {
      startGeneratingModel()
    }
    
    // MARK: Private methods
    private func startGeneratingModel() {
        setupProporties()
        
        $singInState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.title = self.getTitle()
                self.subTitle = self.getSubTitle()
                self.singInDeepColorButtonConfig = self.getSingInDeepColorButtonConfig()
                self.singInTextButtonConfig = self.getSingInTextButtonConfig()
            })
            .store(in: &cancellableSet)
    }
    
    private func setupProporties() {
        title = getTitle()
        subTitle = getSubTitle()
        singInDeepColorButtonConfig = getSingInDeepColorButtonConfig()
        singInTextButtonConfig = getSingInTextButtonConfig()
        loginTextFieldConfig = getLoginTextFieldConfig()
        passwordTextFieldConfig = getPasswordTextFieldConfig()
    }
    
    private func getSingInDeepColorButtonConfig() -> TPButton.Config {
       let title = getTitleNameSingInDeepColorButton()
       return .init(title: title, action: nil)
    }
    
    private func getSingInTextButtonConfig() -> TPButton.Config {
       let title = getTitleNameSingInTextButton()
       return .init(title: title, action: signInTextButtonTapAction())
    }
    
    func getLoginTextFieldConfig() -> TPIconTextFiled.Config {
        let placeholder = Constants.TextFields.emailPlaceholder
        let image = Constants.TextFields.emailImageInDisabled
        let config: TPIconTextFiled.Config = .init(
            placeholder: placeholder,
            image: image,
            text: nil
        )
        return config
    }
    
    func getPasswordTextFieldConfig() -> TPIconTextFiled.Config {
        let placeholder = Constants.TextFields.passwordPlaceholder
        let image = Constants.TextFields.passwordImageInDisabled
        let config: TPIconTextFiled.Config = .init(
            placeholder: placeholder,
            image: image,
            text: nil
        )
        return config
    }
    
    private func signInTextButtonTapAction() -> VoidHandler {
        let action: VoidHandler = {
            switch self.singInState {
            case .signIn:
                self.singInState = .signUp
            case .signUp:
                self.singInState = .signIn
            }
        }
        return action
    }
    
    private func getTitle() -> String {
        switch singInState {
        case .signIn:
            return Constants.Title.titleSinIn
        case .signUp:
           return Constants.Title.titleSinUp
        }
    }
    
    private func getSubTitle() -> String {
        switch singInState {
        case .signIn:
            return Constants.SubTitle.subtitleSinIn
        case .signUp:
           return Constants.SubTitle.subTitleSinUp
        }
    }
    
    private func getTitleNameSingInDeepColorButton() -> String {
        switch singInState {
        case .signIn:
            return Constants.Buttons.singIn
        case .signUp:
            return Constants.Buttons.singUp
        }
    }
    
    private func getTitleNameSingInTextButton() -> String {
        switch singInState {
        case .signIn:
            return Constants.Buttons.singUp
        case .signUp:
            return Constants.Buttons.singIn
        }
    }
}
