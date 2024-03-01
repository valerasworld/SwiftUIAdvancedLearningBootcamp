//
//  ScrollViewAppleNavBarAnimation.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 01.03.2024.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey3: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    
    func onScrollViewOffsetChange3(action: @escaping (_ offset: CGFloat) -> ()) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey3.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey3.self, perform: { value in
                action(value)
//                var newValue = value
//                if newValue <= 45 && newValue > 75 {
//                    value = 45
//                }
            })
    }
}

struct ScrollViewAppleNavBarAnimation: View {
    
    let title: String = "New Title g here!"
    @State private var scrollViewOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 23) {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 75.0)
                    .onScrollViewOffsetChange3 { value in
                        self.scrollViewOffset = value
                    }
                
                contentLayer
                    .scrollTargetLayout()
                
            }
            .padding()
            .safeAreaInset(edge: .top) {
                navBarLayer
            }
            
            
        }
        
        
        
        
//        .overlay(
//            Text("\(scrollViewOffset)")
//        )
        
        
//        .overlay(
//            navBarLayer/*.opacity(scrollViewOffset < 66.4 ? 1.0 : 0.0)*/
//            , alignment: .top)
        //        .animation(.easeIn, value: scrollViewOffset)
//        .background(Image("screen").resizable().ignoresSafeArea().scaledToFit())
        
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp2()
}

extension ScrollViewAppleNavBarAnimation {
    
    private func maskOffset() -> CGFloat {
        
        let startMaskScrollOffsetValue: CGFloat = 91
        
        let startMaskOffset: CGFloat = 8
        let finishMaskOffset: CGFloat = 33
        
        let scrollOfsset: CGFloat = startMaskScrollOffsetValue - scrollViewOffset
        
        let transitionOffset: CGFloat = finishMaskOffset - startMaskOffset
        
        let progress = min(max(scrollOfsset / transitionOffset , 0), 1)
        
        return startMaskOffset + transitionOffset * progress
    }
    
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .opacity(scrollViewOffset >= 66.34 ? 1.0 : 0.0)
            .frame(maxWidth: .infinity, alignment: .leading)
            .animation(.linear(duration: 0.1), value: scrollViewOffset)
            .mask {
                Rectangle()
                    .offset(y: maskOffset())
            }
            .animation(.none, value: scrollViewOffset)

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
    
    private func materialBackgroundOpacity() -> Double {
        
        let startOpacityScrollOffset: Double = 51
        
        let startOpacityValue: Double = 0
        let finishOpacityValue: Double = 1
        
        let scrollOfsset: CGFloat = startOpacityScrollOffset - scrollViewOffset
        
        let transitionOffset: CGFloat = 6
        
        let progress = min(max(scrollOfsset / transitionOffset, 0), 1)
        
        return startOpacityValue + finishOpacityValue * progress
    }
    
    
    
    private var navBarLayer: some View {
        VStack(spacing: 0) {
            
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .offset(y: -2)
                .opacity(scrollViewOffset <= 66.4 ? 1.0 : 0.0)
                .animation(.linear(duration: 0.2), value: scrollViewOffset)
                .background(Material.bar.opacity(materialBackgroundOpacity()))
            
            Rectangle()
                .fill(Color.black.opacity(0.3 * materialBackgroundOpacity()))
                .frame(height: 1 / UIScreen.main.scale)
        }
        .animation(.none, value: scrollViewOffset)
        
    }
}
