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
    
    // MARK: Initialisations
    private func startGeneratingModel() {
        title = getTitle()
        subTitle = getSubTitle()
        singInDeepColorButtonConfig = getSingInDeepColorButtonConfig()
        
        $singInState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.title = self.getTitle()
                self.subTitle = self.getSubTitle()
                self.singInDeepColorButtonConfig = self.getSingInDeepColorButtonConfig()
            })
            .store(in: &cancellableSet)
    }
    
    private func getSingInDeepColorButtonConfig() -> TPButton.Config {
       let title = getTitleNameSingInDeepColorButton()
       return .init(title: title, action: nil)
    }
    
    private func signInTapAction() -> VoidHandler {
        let action: VoidHandler = {
            self.singInState = .signUp
        }
        return action
    }
    
    private func getTitle() -> String {
        switch singInState {
        case .signIn:
            return TP.SingInScene.Constants.Title.titleSinIn
        case .signUp:
           return TP.SingInScene.Constants.Title.titleSinUp
        }
    }
    
    private func getSubTitle() -> String {
        switch singInState {
        case .signIn:
            return TP.SingInScene.Constants.SubTitle.subtitleSinIn
        case .signUp:
           return TP.SingInScene.Constants.SubTitle.subTitleSinUp
        }
    }
    
    private func getTitleNameSingInDeepColorButton() -> String {
        switch singInState {
        case .signIn:
            return  TP.SingInScene.Constants.Buttons.singIn
        case .signUp:
            return TP.SingInScene.Constants.Buttons.singUp
        }
    }
}
