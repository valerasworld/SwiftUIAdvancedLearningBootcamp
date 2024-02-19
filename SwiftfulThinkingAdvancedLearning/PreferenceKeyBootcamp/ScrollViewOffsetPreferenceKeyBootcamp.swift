//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 18.02.2024.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    
    func onScrollViewOffsetChange(action: @escaping (_ offset: CGFloat) -> ()) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    
    let title: String = "New Title here!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            Rectangle()
                .opacity(0)
                .frame(maxWidth: .infinity)
                .frame(height: 34)
            
            ScrollView {
                VStack {
                    titleLayer
                        .opacity(Double(scrollViewOffset) / 75.0)
                        .onScrollViewOffsetChange { value in
                            self.scrollViewOffset = value
                        }
                    
                    contentLayer
                }
                .padding()
            }
            .overlay(
                Text("\(scrollViewOffset)")
            )
        }
        .overlay(
            navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
        , alignment: .top)
        
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
   
    private var titleLayer: some View {
        VStack(spacing: 0) {
//            Rectangle()
//                .opacity(0)
//                .frame(maxWidth: .infinity)
//                .frame(height: 26)
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 26)
        }
    }
    
    private var contentLayer: some View {
        ForEach(0..<5) { _ in
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue.opacity(1))
                .frame(width: 300, height: 223)
        }
    }
    
    private var navBarLayer: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Material.bar)
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(height: 1 / UIScreen.main.scale)
        }
    }
}
