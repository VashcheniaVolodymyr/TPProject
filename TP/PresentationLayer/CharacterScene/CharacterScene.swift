//
//  CharacterScene.swift
//  TP
//
//  Created by Developer on 27.11.2022.
//

import SwiftUI
protocol CharacterSceneVPM: ObservableObject {
    var title: String { get }
}

struct CharacterScene<ViewModel: CharacterSceneVPM>: View {
    @ObservedObject var viewModel: ViewModel
    @Namespace private var animation
    @State private var isFlipped: Bool = false
    
    var body: some View {
       mainView
    }
    
    private var mainView: some View {
        ZStack {
            Rectangle()
                .fill(Color.tpDarkGray)
                .ignoresSafeArea()
            
            VStack {
                TabView {
                    ZStack {
                        Rectangle()
                            .fill(Color.tpMidGray)
                            .ignoresSafeArea()
                        titleView
                            .tabItem({
                                Image.passwordIconInDisabled
                                    .foregroundColor(.white)
                            })
                            .tag(1)
                        titleView
                            .tabItem({
                                Image.passwordIconInDisabled
                                    .foregroundColor(.blue)
                            })
                            .tag(2)
                    }
                }
                Spacer()
            }
        }
    }
    
    private var titleView: some View {
        ZStack {
            Rectangle()
                .fill(Color.tpDarkGray)
            VStack {
                HStack(alignment: .center) {
                    Text(viewModel.title)
                        .foregroundColor(.white)
                        .font(Font.title)
                        .padding(.top, 40)
                        .padding(.leading, 24)
                    Spacer()
                }
            }
        }
    }
}

struct CharacterScene_Previews: PreviewProvider {
    static var previews: some View {
        CharacterScene(viewModel: CharacterSceneViewModel())
    }
}
