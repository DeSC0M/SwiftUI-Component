//
//  AnimatableText.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 13.10.2020.
//

import SwiftUI

struct AnimatableText: View {
    @State var flag1 = false
    @State var flag2 = false
    @State var flag3 = false
    var body: some View {
        VStack {
            Button {
                flag1.toggle()
            } label: {
                Text("1")
            }
            
            Button {
                flag2.toggle()
            } label: {
                Text("2")
            }
            
        }
        .sheet(isPresented: $flag1, content: {
            Text("1")
        })
        .sheet(isPresented: $flag2, content: {
            Text("2")
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    flag3.toggle()
                })
                .sheet(isPresented: $flag3, content: {
                    Text("3")
                })
        })
    }
}

struct Plsh: View, Equatable {
    var flag: Bool
    
    var body: some View {
        HStack {
            Text("Hello, World! Hello, World! Hello, World!")
                .animatableFont(size: flag ? 10 : 50)
                .offset(y: flag ? -20: 0)
            Spacer()
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.flag == rhs.flag
    }
}

struct AnimatableText_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableText()
    }
}

struct AnimatableCustomFontModifier: AnimatableModifier {
    var size: CGFloat
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
}

extension View {
    func animatableFont(size: CGFloat) -> some View {
        self.modifier(AnimatableCustomFontModifier(size: size))
    }
}
