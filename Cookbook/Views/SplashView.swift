//
//  SplashView.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import SwiftUI

struct SplashView: View {
    @State private var startPoint: UnitPoint = .init(x: -1.0, y: 0.5)
    @State private var endPoint: UnitPoint = .leading
    
    private let gradient: Gradient = .init(stops: [
        .init(color: .black, location: 0),
        .init(color: .white, location: 0.5),
        .init(color: .black, location: 1),
    ])
    
    var body: some View {
        ZStack {
            Text(LocalizedStringKey("Cookbook"))
                .font(.largeTitle)
                .bold()
            
            LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
                .opacity(0.7)
                .blendMode(.screen)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        startPoint = .trailing
                        endPoint = UnitPoint(x: 2.0, y: 0.5)
                    }
                }
        }
    }
}

#Preview {
    SplashView()
}
