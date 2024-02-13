//
//  CustomCurvesBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Валерий Зазулин on 13.02.2024.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
        WaterShape()
            .fill(LinearGradient(
                colors: [Color.blue, Color.cyan],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            )
            .ignoresSafeArea()
//            .frame(width: 200, height: 200)
    }
}

#Preview {
    CustomCurvesBootcamp()
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 40),
                clockwise: true)
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            // bottom
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY - 65),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            
            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))

        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.4))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.6))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
