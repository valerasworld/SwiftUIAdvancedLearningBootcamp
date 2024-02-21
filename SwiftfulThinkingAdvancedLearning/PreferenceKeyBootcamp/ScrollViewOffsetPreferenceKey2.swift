//
//  ScrollViewOffsetPreferenceKey2.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 20.02.2024.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey2: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    
    func onScrollViewOffsetChange2(action: @escaping (_ offset: CGFloat) -> ()) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey2.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey2.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp2: View {
    
    let title: String = "New Title g here!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 23) {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 75.0)
                    .onScrollViewOffsetChange2 { value in
                        self.scrollViewOffset = value
                    }
                
                contentLayer
            }
            .padding(.top, 28)
            .padding()
        }
        .overlay(
            Text("\(scrollViewOffset)")
        )
        
        
        .overlay(
            navBarLayer/*.opacity(scrollViewOffset < 66.4 ? 1.0 : 0.0)*/
            , alignment: .top)
        //        .animation(.easeIn, value: scrollViewOffset)
        .background(Image("screen").resizable().ignoresSafeArea().scaledToFit())
        
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp2()
}

extension ScrollViewOffsetPreferenceKeyBootcamp2 {
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .opacity(scrollViewOffset > 66.4 ? 1.0 : 0.0)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.linear(duration: 0.1), value: scrollViewOffset)
            .background(Color.yellow)

    }
    
    private var contentLayer: some View {
        VStack(spacing: 8) {
            ForEach(0..<5) { _ in
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.red)
                    .frame(width: 300, height: 223)
            }
        }
    }
    
    private var navBarLayer: some View {
        VStack(spacing: 0) {
            
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .offset(y: -2)
                .opacity(scrollViewOffset <= 66.4 ? 1.0 : 0.0)
                .background(scrollViewOffset >= 46.3 ? .white : .clear)
                .background(Material.bar.opacity(scrollViewOffset < 46.3 ? 1 : 0))
            
            Rectangle()
                .fill(Color.black.opacity(scrollViewOffset < 46.3 ? 0.3 : 0))
                .frame(height: 1 / UIScreen.main.scale)
        }
        .animation(.linear(duration: 0.1), value: scrollViewOffset)
    }
}
