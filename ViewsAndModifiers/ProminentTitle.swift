//
//  ProminentTitle.swift
//  ViewsAndModifiers
//
//  Created by Мария Газизова on 16.07.2024.
//

import SwiftUI

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}
