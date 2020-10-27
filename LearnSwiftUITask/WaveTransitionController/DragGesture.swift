//
//  DragGesture.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 31.08.2020.
//

import SwiftUI

extension DragGesture {
    func swipeGesture(fingerPosition: Binding<CGPoint>, isNeedMakeOffset: Binding<Bool>, side: SlideSide) ->some Gesture {
        self.onChanged { (value) in
            isNeedMakeOffset.wrappedValue = false
            fingerPosition.wrappedValue = value.location
        }
        .onEnded { (value) in
            let w = UIScreen.main.bounds.width
            if side == .left && value.predictedEndLocation.x > UIScreen.main.bounds.midX {
                fingerPosition.wrappedValue.x = w*2
            } else if side == .right && value.predictedEndLocation.x < UIScreen.main.bounds.midX {
                fingerPosition.wrappedValue.x = -w
            } else {
                fingerPosition.wrappedValue.x = side == .left ? 2 : UIScreen.main.bounds.maxX - 2
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isNeedMakeOffset.wrappedValue = true
                }
            }
        }
    }
}
