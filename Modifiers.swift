//
//  Modifiers.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct BentoBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

struct WiggleAnimation: ViewModifier {
    @Environment(\.editMode) var shouldWiggle
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(isEditing() ? 2.5 : 0))
            .animation(
                isEditing()
                ? Animation.easeInOut(duration: 0.15).repeatForever(autoreverses: true)
                : Animation.default,
                value: isEditing()
            )
    }
    
    private func isEditing() -> Bool {
        if self.shouldWiggle?.wrappedValue == .active {
            return true
        } else {
            return false
        }
    }
}
