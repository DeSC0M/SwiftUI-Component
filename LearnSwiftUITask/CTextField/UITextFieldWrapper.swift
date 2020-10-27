//
//  UITextFieldWrapper.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 26.10.2020.
//

import Foundation
import SwiftUI
import Combine

final class UITextFieldWrapper: UIViewRepresentable {
    
    @Binding private var text: String
    
    private var placeholder: String
    private var keyboardType: UIKeyboardType
    private var autocapitalizationType: UITextAutocapitalizationType
    private var onEditingChanged: ((Bool) -> Void)
    
    init(_ placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType, autocapitalizationType: UITextAutocapitalizationType, onEditingChanged: @escaping ((Bool) -> Void) = {_ in}) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.autocapitalizationType = autocapitalizationType
        _text = text
        self.onEditingChanged = onEditingChanged
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<UITextFieldWrapper>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.placeholder = placeholder
        textField.text = text
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = autocapitalizationType
        textField.inputAccessoryView = {
            let screenWidth = UIScreen.main.bounds.width
            let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
            let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let barButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(endEditing))
            toolBar.setItems([flexible, barButton], animated: false)
            return toolBar
        }()
        context.coordinator.setup(textField)
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    @objc func endEditing() {
        UIApplication.shared.endEditing()
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: UITextFieldWrapper
        
        init(_ textFieldContainer: UITextFieldWrapper) {
            self.parent = textFieldContainer
        }
        
        func setup(_ textField: UITextField) {
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        @objc func textFieldDidChange(_ textField: UITextField) {
            let newPosition = textField.endOfDocument
            parent.text = textField.text ?? ""
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            UIApplication.shared.endEditing()
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onEditingChanged(true)
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onEditingChanged(false)
        }
    }
}
