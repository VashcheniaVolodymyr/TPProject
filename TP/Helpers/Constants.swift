//
//  Constants.swift
//  TP
//
//  Created by Developer on 22.11.2022.
//

import Foundation
import SwiftUI

struct TP {
    struct SingInScene {
        struct Constants {
            enum Title {
                static let titleSinUp = "Welkome!"
                static let titleSinIn = "Welkome back!"
            }
            
            enum SubTitle {
                static let subTitleSinUp = "Create an account to get started"
                static let subtitleSinIn = "Log in to your account"
            }
            
            enum Buttons {
                static let singIn = "Sing in"
                static let singUp = "Sing up"
            }
            
            enum TextFields {
                static let emailPlaceholder = "Your email"
                static let passwordPlaceholder = "Your password"
                static let emailImageInActive = Image.emailIconInActive
                static let emailImageInDisabled = Image.emailIconDisabled
                static let passwordImageInActive = Image.passwordIconInActive
                static let passwordImageInDisabled = Image.passwordIconInDisabled
            }
            
        }
    }
}
