//
//  SplashScreenView.swift
//  Aike
//
//  Created by Ferry Setiawan on 26/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var showHome = false
    
    var body: some View {
        ZStack {
            if showHome {
                HomeView()
                    .transition(.slide)
            } else {
                Color(hex: 0xF3E8E1)
                    .ignoresSafeArea()
                AddLottie(name: "Splash", loopMode: .loop)
                    .scaleEffect(1)
                    .position(CGPoint(x:600, y: 410.0))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) {
                withAnimation {
                    self.showHome = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
