//
//  File.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 20.10.2020.
//

import Foundation
import SwiftUI
import MapKit

struct TestTabBar: View {
    @State var tag = 1
    @State var coord = MKCoordinateRegion()
    @State var tabBarHeight: CGFloat = 60
    
    var body: some View {
        ZStack(alignment: .bottom) {
                TabView(selection: $tag) {
                    Color.green
                        .tag(1)
                        .padding(.bottom, tabBarHeight)
                    Map(coordinateRegion: $coord)
                        .padding(.bottom, tabBarHeight)
                        .tag(2)
                    Color.yellow
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(tag == 3 ? .bottom : .horizontal)
                .animation(.none)
            
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    HStack {
                        Text("1")
                            .padding()
                            .onTapGesture(count: 1, perform: {
                                tag = 1
                            })
                            .foregroundColor(tag == 1 ? .red : .white)
                        Text("2")
                            .padding()
                            .onTapGesture(count: 1, perform: {
                                tag = 2
                            })
                            .foregroundColor(tag == 2 ? .red : .white)
                        Text("3")
                            .padding()
                            .onTapGesture(count: 1, perform: {
                                tag = 3
                            })
                            .foregroundColor(tag == 3 ? .red : .white)
                    }
                    .background(Color.blue)
                )
                .frame(height: tag == 3 ? 0 : tabBarHeight)
                .offset(y: tag == 3 ? tabBarHeight : 0)
                .animation(.easeInOut)
        }
    }
}

struct File_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestTabBar()
            //            TestTabBar()
            //                .previewDevice("iPhone 8")
        }
    }
}

extension View {
    
    @ViewBuilder
    func ignoreBottom(flag: Bool) -> some View {
        if flag {
            self.edgesIgnoringSafeArea(.bottom)
        } else {
            self
        }
    }
}
