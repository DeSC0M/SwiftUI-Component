//
//  TextFieldWithFromatterView.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 24.10.2020.
//

import SwiftUI

struct TextFieldWithFromatterView: View {
    @State var text = ""
    @State var text2 =  ""
    let phoneNumberFormatter = PhoneNumberFormatter()
    var body: some View {
        VStack {
            Text("Hello, World!" as NSObject, formatter: phoneNumberFormatter)
            Text("Hello, World!")
            TextField("Test", text: $text)
                .onChange(of: text, perform: { value in
                    text = phoneNumberFormatter.string(for: value) ?? text
                })
        }
        
    }
}

struct TextFieldWithFromatterView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithFromatterView()
    }
}
