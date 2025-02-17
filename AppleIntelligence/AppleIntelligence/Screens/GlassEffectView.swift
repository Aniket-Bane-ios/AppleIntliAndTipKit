//
//  GlassEffectView.swift
//  AppleIntelligence
//
//  Created by Aniket Bane on 16/02/25.
//

import SwiftUI
import TipKit

struct GlassEffectView: View {
    @Binding var prompt: String
    @Binding var generateImage: Bool
    @State private var rotate = false
    @StateObject private var keyboardObserver = KeyboardObserver()
    let addPrompttip = AddPromptTipModel()
    var body: some View {
        VStack{
            ZStack {
                BlurView()
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .cornerRadius(24)
                HStack {
                    TextField(
                        "",
                        text: $prompt,
                        prompt: Text("Ask to do?").foregroundStyle(.secondary)
                    )
                        .padding(.leading, 20)
                        .foregroundStyle(Color(UIColor.lightGray))
                    Button(action: {
                        generateImage = true
                        Helpers.shared.dismissKeyboard()
                        Task {await AddPromptTipModel.promptTip.donate()}
                    }) {
                        Image(systemName: "apple.intelligence")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        .appleIntelligenceYellow,
                                        .appleIntelligencePink,
                                        .appleIntelligenceIndigo,
                                        .appleIntelligenceBlue
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .mask(
                                    Image(systemName: "apple.intelligence")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                )
                            )
                            .symbolEffect(
                                .rotate,
                                options: .speed(0.5),
                                isActive: rotate
                            )
                    }
                    .padding(.trailing, 20)
                }
                .frame(maxWidth: UIScreen.main.bounds.width)
            }
            .padding(.bottom, keyboardObserver.keyboardHeight)
            .animation(.easeOut(duration: 0.3), value: keyboardObserver.keyboardHeight)
            .onAppear {
                rotate = true
            }
            .popoverTip(addPrompttip)
        }
        .padding(.top, 600)
    }
    
}


#Preview {
    GlassEffectView(prompt: .constant(""), generateImage: .constant(false))
}
