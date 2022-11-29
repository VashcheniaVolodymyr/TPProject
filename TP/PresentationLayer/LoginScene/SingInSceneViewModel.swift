//
//  LoginSceneViewModel.swift
//  TP
//
//  Created by Developer on 22.11.2022.
//

import Foundation
import Combine
import SwiftUI

enum SingInState {
    case signIn
    case signUp
}

enum SignInFieldsStatus {
    case loginNotFilled
    case passwordNotFilled
    case allNotFilled
    case fieldsFilled
}

final class SingInSceneViewModel: SingInSceneVMP {
    typealias Constants = TP.SingInScene.Constants
    
    // MARK: Public proporties
    @Published var title: String = ""
    @Published var subTitle: String = ""
    @Published var loginTextFieldConfig: TPIconTextField.Config = .empty
    @Published var passwordTextFieldConfig: TPIconTextField.Config = .empty
    @Published var singInDeepColorButtonConfig: TPButton.Config = .empty
    @Published var singInTextButtonConfig: TPButton.Config = .empty
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var textFieldsStatus: SignInFieldsStatus = .allNotFilled
    @Published var singInButtonTapped: Bool = false
    
    // MARK: Private proporties
    @Published private var singInState: SingInState = .signUp
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: Initialisations
    init() {
      startGeneratingModel()
    }
    
    // MARK: Private methods
    private func startGeneratingModel() {
        setupProporties()
        
        Publishers.CombineLatest($singInState, $textFieldsStatus)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ , status in
                guard let self = self else { return }
                self.title = self.getTitle()
                self.subTitle = self.getSubTitle()
                self.singInDeepColorButtonConfig = self.getSingInDeepColorButtonConfig(status: status)
                self.singInTextButtonConfig = self.getSingInTextButtonConfig()
            }
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest(isEmailEmptyTextPublisher, isPasswordEpmtyTextPublisher)
            .receive(on: RunLoop.main)
            .map { email, password -> SignInFieldsStatus in
                if email { return .loginNotFilled }
                if password { return .passwordNotFilled }
                if email && password { return .allNotFilled }
                return .fieldsFilled
            }
            .assign(to: \.textFieldsStatus, on: self)
            .store(in: &cancellableSet)
        
        $textFieldsStatus
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] status in
                guard let self = self else { return }
                switch status {
                case .fieldsFilled:
                    self.singInDeepColorButtonConfig = self.getSingInDeepColorButtonConfig(status: .fieldsFilled)
                default:
                    break
                }
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
    
    private func signInTextButtonTapAction() -> VoidHandler {
        let action: VoidHandler = { [unowned self] in
            switch self.singInState {
            case .signIn:
                self.singInState = .signUp
            case .signUp:
                self.singInState = .signIn
            }
        }
        return action
    }
    
    private func signInDeepButtonTapAction() -> VoidHandler {
        let action: VoidHandler = {
            self.singInButtonTapped = true
        }
        return action
    }
}

extension SingInSceneViewModel {
    private var isFiledsFilledPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isEmailEmptyTextPublisher, isPasswordEpmtyTextPublisher)
            .receive(on: RunLoop.main)
            .map { !$0 && !$1 }
            .eraseToAnyPublisher()
    }
    
    private var isEmailEmptyTextPublisher: AnyPublisher<Bool, Never> {
        $emailText
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordEpmtyTextPublisher: AnyPublisher<Bool, Never> {
        $passwordText
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
}

extension SingInSceneViewModel {
    private func getSingInDeepColorButtonConfig(status: SignInFieldsStatus = .allNotFilled) -> TPButton.Config {
        let title = getTitleNameSingInDeepColorButton()
        var action: VoidHandler? = nil
        switch status {
        case .fieldsFilled:
            action = signInDeepButtonTapAction()
        default:
            break
        }
        return .init(title: title, action: action)
    }
    
    private func getSingInTextButtonConfig() -> TPButton.Config {
       let title = getTitleNameSingInTextButton()
       return .init(title: title, action: signInTextButtonTapAction())
    }
    
    func getLoginTextFieldConfig() -> TPIconTextField.Config {
        let placeholder = Constants.TextFields.emailPlaceholder
        let image = Constants.TextFields.emailImageInDisabled
        let imageInActive = Constants.TextFields.emailImageInActive
        let config: TPIconTextField.Config = .init(
            placeholder: placeholder,
            imageSet: (imageInActive,image)
        )
        return config
    }
    
    func getPasswordTextFieldConfig() -> TPIconTextField.Config {
        let placeholder = Constants.TextFields.passwordPlaceholder
        let image = Constants.TextFields.passwordImageInDisabled
        let imageInActive = Constants.TextFields.passwordImageInActive
        let config: TPIconTextField.Config = .init(
            placeholder: placeholder,
            imageSet: (imageInActive,image)
        )
        return config
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
