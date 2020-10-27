//
//  WaveTransitionController.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 31.08.2020.
//

import SwiftUI

struct WaveTransitionController: View {
    
    @State var fingerPosition: [CGPoint] = [
        .init(x: 2, y: UIScreen.main.bounds.midY),
        .init(x: UIScreen.main.bounds.maxX - 2, y: UIScreen.main.bounds.maxX)
    ]
    @State var needMakeOffset: [Bool] = [
        true,
        true
    ]
    
    @State var scaleText: CGFloat = 1
    
    var body: some View {
        ZStack {
            contentView()
                .zIndex(0)
            leftSlideView()
                .zIndex(needMakeOffset[0] ? 1 : 2)
                .offset(x: needMakeOffset[0] ? -UIScreen.main.bounds.width + 2: 0)
                .animation(.none)
                .clipShape(WaveTransitionShape(slideSide: .left, fingerPosition: fingerPosition[0]))
                .gesture(DragGesture().swipeGesture(fingerPosition: $fingerPosition[0], isNeedMakeOffset: $needMakeOffset[0], side: .left))
            rightSlideView()
                
                .zIndex(needMakeOffset[1] ? 1 : 2)
                .offset(x: needMakeOffset[1] ? UIScreen.main.bounds.width - 2: 0)
                .animation(.none)
                .clipShape(WaveTransitionShape(slideSide: .right, fingerPosition: fingerPosition[1]))
                .gesture(DragGesture().swipeGesture(fingerPosition: $fingerPosition[1], isNeedMakeOffset: $needMakeOffset[1], side: .right))
                
        }
        .animation(.spring())
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
        
    }
    
    @ViewBuilder
    func contentView() -> some View {
        Color.blue
            .overlay(Button(action: {
                withAnimation(Animation.linear(duration: 1).delay(1)) {
                    scaleText = 2
                }
                
                withAnimation(Animation.default.delay(2)) {
                    scaleText = 1
                }
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    .font(.largeTitle)
            })
            .foregroundColor(.black)
                        .accessibility(identifier: "Test").scaleEffect(scaleText))
            
            
            .shadow(radius: 0)
    }
    
    @ViewBuilder
    func leftSlideView() -> some View {
        Color.yellow
            .overlay(Text("Hello 1"))
            .shadow(radius: 0)
    }
    
    @ViewBuilder
    func rightSlideView() -> some View {
        Color.red
            .overlay(Text("Hello 1"))
            .shadow(radius: 0)
    }
}

struct WaveTransitionController_Previews: PreviewProvider {
    static var previews: some View {
        WaveTransitionController()
    }
}
