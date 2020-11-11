//
//  KeyboardAware.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 10/15/20.
//

// Code From: https://github.com/ralfebert/KeyboardAwareSwiftUI


import SwiftUI

struct KeyboardAware: ViewModifier {
    @ObservedObject private var keyboard = KeyboardInfo.shared

    func body(content: Content) -> some View {
        content
            .padding(.bottom, self.keyboard.height)
            .edgesIgnoringSafeArea(self.keyboard.height > 0 ? .bottom : [])
            .animation(.easeOut)
    }
}

extension View {
    public func keyboardAware() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAware())
    }
}
