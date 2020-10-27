//
//  ViewWithTextAndButton.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 27.10.2020.
//

import SwiftUI
import Combine

struct ViewWithTextAndButton: View {
    @ObservedObject var mainViewModel = MainViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 50)
                TextFieldView(textViewModel: $mainViewModel.textViewModel)
                Spacer()
                    .frame(width: 50)
            }
            Button {
                print("some action")
            } label: {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .frame(width: 100, height: 100, alignment: .center)
            }
            .foregroundColor(mainViewModel.isDisableButton ? .gray : .blue)
        }
    }
}

struct TextFieldView: View {
    @Binding var textViewModel: TextViewModel
    var body: some View {
        UITextFieldWrapper("Test", text: $textViewModel.text, keyboardType: .default, autocapitalizationType: .none) { _ in
            textViewModel.isEditing = true
        }
        .frame(height: 60)
        .padding(.all, 5)
        .background(
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .stroke(lineWidth: 1.0)
                .foregroundColor(textViewModel.isValid || !textViewModel.isEditing ? .blue : .red)
        )
            .onChange(of: textViewModel.text, perform: { value in
                textViewModel.text = value.phoneFromat()
            })
    }
}

final class MainViewModel: ObservableObject {
    @Published var textViewModel = TextViewModel()
    @Published var isValid: Bool = true
    
    var isDisableButton: Bool {
        textViewModel.text.isEmpty || !textViewModel.isValid
    }
    
    private var cancellbleSet: Set<AnyCancellable> = []
    
    init() {
        textViewModel.$isValid
            .map { value in
                return value
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellbleSet)
    }
    
    deinit {
        cancellbleSet.removeAll()
    }
}

final class TextViewModel: ObservableObject {
    @Published var text = ""
    @Published var isValid = false
    @Published var isEditing = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $text
            .map { value in
                return value.removeAllSpace().makeNumberString().count == 11
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    
    deinit {
        cancellableSet.removeAll()
    }
}

struct ViewWithTextAndButton_Previews: PreviewProvider {
    static var previews: some View {
        ViewWithTextAndButton()
    }
}
