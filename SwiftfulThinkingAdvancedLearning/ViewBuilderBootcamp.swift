//
//  ViewBuilderBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 17.02.2024.
//

import SwiftUI

struct HeaderViewRegular: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("Description")
                .font(.callout)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        HeaderViewRegular()
        
        HeaderViewGeneric(title: "Generic Title") {
            HStack {
                Text("Hi")
                Image(systemName: "heart.fill")
                Text("Hi")
                
            }
        }
        
        CustomHStack {
            Text("Hi")
            Text("Hi")
        }
        
        HStack {
            Text("Hi")
            Text("Hi")
        }
        
        Spacer()
    }
}

#Preview {
//    ViewBuilderBootcamp()
    LocalViewBuilder(type: .two)
}

struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View {
        Text("One")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("Two")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}
