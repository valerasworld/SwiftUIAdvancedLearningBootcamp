//
//  ClippedTextTest.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 21.02.2024.
//

import SwiftUI

struct ClippedTextTest: View {
    
    @State var sliderValue: Int = 2
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .border(Color.gray)
                .mask {
                    Rectangle()
                        .frame(height: 100)
                        .offset(y: 50)
                }
            
            Divider()
            
            HStack(spacing: 50) {
                Button("0%") {
                    sliderValue = 0
                }
                Button("50%") {
                    sliderValue = 1
                }
                Button("100%") {
                    sliderValue = 2
                }
            }
        }
            
                
            
    }
}

#Preview {
    ClippedTextTest()
}
