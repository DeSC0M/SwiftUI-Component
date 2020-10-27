//
//  ScrollViewWithGeometry.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 28.08.2020.
//

import SwiftUI

struct ScrollViewWithGeometry: View {
    @State var leadPadding = (UIScreen.main.bounds.width - 200)/2
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.25)
                .ignoresSafeArea()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0...10, id: \.self) { i in
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.purple)
                                .shadow(color: Color.black.opacity(0.7), radius: 5, x: 4, y: 4)
                                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -4, y: -4)
                                .rotation3DEffect(
                                    Angle(degrees: Double(geometry.frame(in: .global).minX  - leadPadding) / -10),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                        }
                        .frame(width: 200, height: 300)
                    }
                }
                .padding(.horizontal, leadPadding)
                .frame(height: 400)
            }
        }
    }
}

struct ScrollViewWithGeometry_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewWithGeometry()
    }
}
