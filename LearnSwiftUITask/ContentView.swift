//
//  ContentView.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 27.08.2020.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @State var isUsing = false
    var body: some View {
        CustomAlert(title: "E-mail для оповещений", message: nil, actions: [
            .init(title: "Cancel", type: .cancel, action: {}),
            .init(title: "Save", type: .default, action: {})
        ]) {
            TextField("Введите Email", text: $text)
                .padding(.horizontal, 25)
                .padding(.bottom, 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct NavView: View {
    var body: some View {
        NavigationView {
            NavigationLink("Go to test", destination: Text("test 2"))
            
                .navigationTitle("Test")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TestList: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: .continuous)
                    .frame(width: 300, height: 500)
                    .overlay(l().clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)))
                Spacer()
            }
            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        
    }
    
    @ViewBuilder
    func l() -> some View {
        List {
            Section(header: h()) {
                ForEach(0...10, id: \.self) { i in
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        VStack(spacing: 4) {
                            HStack {
                                Text("I = \(i)")
                                Spacer()
                            }
                            Rectangle()
                                .frame(height: 0.5)
                        }
                        .offset(x: 40, y: 6)
                    })
                    .hideRowSeparator()
                }
            }
            
            Section(header: h()) {
                ForEach(0...10, id: \.self) { i in
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        VStack(spacing: 4) {
                            HStack {
                                Text("I = \(i)")
                                Spacer()
                            }
                            Rectangle()
                                .frame(height: 0.5)
                        }
                        .offset(x: 40, y: 6)
                    })
                    .hideRowSeparator()
                    
                }
            }
        }
//        .listStyle(DefaultListStyle())
        .colorScheme(.light)
    }
    
    @ViewBuilder
    func h() -> some View {
        Rectangle()
            .foregroundColor(.white)
            .padding(.horizontal, -30)
            .overlay(
                HStack {
                    Text("Test")
                    Spacer()
                }
            )
    }
}

extension View {
    @ViewBuilder
    func clearList() -> some View {
        if #available(iOS 14.0, *) {
            self
                
                .listRowBackground(Color.white)
        } else {
            self
        }
    }
}


@available(iOS 14.0, *)
struct HideRowSeparatorModifier: ViewModifier {
    static let defaultListRowHeight: CGFloat = 44
    var insets: EdgeInsets
    var background: Color
    
    
    init(insets: EdgeInsets, background: Color) {
        self.insets = insets
        var alpha: CGFloat = 0
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1, "Setting background to a non-opaque color will result in separators remaining visible.")
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .frame(
                minWidth: 0, maxWidth: .infinity,
                minHeight: Self.defaultListRowHeight,
                alignment: .leading
            )
            .listRowInsets(EdgeInsets())
            .background(background)
    }
}

extension EdgeInsets {
    static let defaultListRowInsets = Self(top: 0, leading: 16, bottom: 0, trailing: 16)
}

extension View {
    @available(iOS 14.0, *)
    func hideRowSeparator(insets: EdgeInsets = .defaultListRowInsets, background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}
