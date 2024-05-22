import SwiftUI

import Lottie


struct AddLottie: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.play()
        return animationView
    }
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
    }
    
}
