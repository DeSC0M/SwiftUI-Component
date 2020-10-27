//
//  Paralax Scroll View.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 27.08.2020.
//

import SwiftUI

struct Paralax_Scroll_View: View {
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color.yellow)
                    .frame(height: 370 + geometry.frame(in: .global).minY)
                    .offset(y: -geometry.frame(in: .global).minY)
                    .offset(x:  geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY/2 : 0)
                    
            }
            .frame(height: 370)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct Paralax_Scroll_View_Previews: PreviewProvider {
    static var previews: some View {
        Paralax_Scroll_View()
    }
}
