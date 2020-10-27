//
//  WaveTransitionShape.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 31.08.2020.
//

import SwiftUI

struct WaveTransitionShape: Shape {
    var slideSide: SlideSide
    var fingerPosition: CGPoint
    
    var animatableData: CGPoint.AnimatableData {
        get { fingerPosition.animatableData }
        set { fingerPosition.animatableData = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            var side: CGFloat = .zero
            let curvControlY: CGFloat = 100
            var halfOffsetX: CGFloat =  .zero
            
            switch slideSide {
            case .left:
                side = .zero - 200
                halfOffsetX = fingerPosition.x/2
            case .right:
                side = rect.maxX + 200
                halfOffsetX = rect.maxX - (rect.maxX - fingerPosition.x)/2
            }
            
            let startPoint: CGPoint = .init(x: side, y: rect.minY)
            let topLineEndPoint: CGPoint = .init(x: halfOffsetX, y: rect.minY - 200)
            
            let bottomLineStartPoint: CGPoint = .init(x: halfOffsetX, y: rect.maxY + 200)
            let endPoint: CGPoint = .init(x: side, y: rect.maxY)
            
            
            
            path.move(to: startPoint)
            path.addLine(to: topLineEndPoint)
            
            path.addCurve(to: fingerPosition,
                          control1: .init(x: halfOffsetX, y: fingerPosition.y / 2),
                          control2: .init(x: fingerPosition.x, y: fingerPosition.y - curvControlY))
            
            path.addCurve(to: bottomLineStartPoint,
                          control1: .init(x: fingerPosition.x, y: fingerPosition.y + curvControlY),
                          control2: .init(x: halfOffsetX, y: rect.maxY - (rect.maxY-fingerPosition.y)/2))
            
            path.addLine(to: endPoint)
            
        }
    }
}
