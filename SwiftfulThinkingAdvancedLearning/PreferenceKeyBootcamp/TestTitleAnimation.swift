//
//  TestTitleAnimation.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 19.02.2024.
//

import SwiftUI

struct TestTitleAnimation: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(0..<5) { _ in
                            RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.red)
                            .frame(width: 300, height: 223)
                            
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .navigationTitle("Navigation Title")
        }
    }
}

#Preview {
    TestTitleAnimation()
}
