//
//  WaveBorderSlider.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 31.08.2020.
//

import SwiftUI

struct WaveBorderSlider: View {
    
    @State var width = UIScreen.main.bounds.width
    @State var dragOffset: CGPoint = .zero
    @State var isOffset = true
    @State var xPosition = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.yellow
            LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                .drawingGroup()
                .offset(x: isOffset ? width : 0)
                .animation(.none)
                .clipShape(WaveBorderShape(width: dragOffset.x.magnitude, yLocation: dragOffset.y))
                .animation(.spring())
                .gesture(DragGesture()
                            .onChanged({ (value) in
                                dragOffset.x = width-value.location.x
                                dragOffset.y = value.location.y
                                xPosition = value.location.x
                                isOffset = false
                            })
                            .onEnded({ (value) in
                                if value.predictedEndLocation.x < width/2 {
                                    dragOffset.x = width * 3
                                    xPosition = 0
                                } else {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        isOffset = true
                                    }
                                    dragOffset.x = .zero
                                    xPosition = width
                                }
                            })
                )
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct WaveBorderShape: Shape {
    var width: CGFloat
    var yLocation: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(width, yLocation) }
        set {
            width = newValue.first
            yLocation = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            let leadingCurvValue: CGFloat = 100//width/2 < 80 ? width/2 + 70 : 100
            
            
                path.move(to: .init(x: rect.maxX, y: rect.minY))
                path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
                path.addLine(to: .init(x: rect.maxX - width/2 + 50, y: rect.maxY + 200))
                
                path.addCurve(
                    to: .init(x: rect.maxX - width, y: yLocation),
                    control1: .init(x: rect.maxX - width/2 + 50, y: yLocation),
                    control2: .init(x: rect.maxX - width, y: yLocation + leadingCurvValue))
                
                path.addCurve(
                    to: .init(x: rect.maxX - width/2 + 50, y: rect.minY - 200),
                    control1: .init(x: rect.maxX - width, y: yLocation - leadingCurvValue),
                    control2: .init(x: rect.maxX - width/2, y: yLocation))
                
                path.addLine(to: .init(x: rect.maxX - width/2 + 50, y: rect.minY))
            
        }
    }
}

struct RectangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addRect(rect)
        }
    }
}

struct WaveBorderSlider_Previews: PreviewProvider {
    static var previews: some View {
        WaveBorderSlider()
    }
}
