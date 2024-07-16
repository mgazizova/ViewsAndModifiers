//
//  GridStackView.swift
//  ViewsAndModifiers
//
//  Created by Мария Газизова on 16.07.2024.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct GridStackView: View {
    var body: some View {
        GridStack(rows: 2, columns: 3) { row, column in
            HStack { // HStack should be used in this case because GridStack wants a content that is View so it can't contain several Views without arranging. Another option is to make content in GridStack a @ViewBuilder, so HStack won't be needed
                Image(systemName: "\(row * 3 + column).circle")
                Text("| R \(row), C \(column) | ")
            }
        }
    }
}

#Preview {
    GridStackView()
}
