//
//  CustomAlert.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 07.10.2020.
//

import SwiftUI

struct CustomAlert<Content: View>: View {
    
    //MARK: - Constant
    let buttonHeight: CGFloat = 35
    //MARK: -
    private let title: String
    private let message: String
    private let content: Content
    private let actions: [CustomAlertAction]
    
    private var showTitle: Bool {
        !title.isEmpty
    }
    
    private var showMessage: Bool {
        !message.isEmpty
    }
    
    init(title: String?,
         message: String?,
         actions: [CustomAlertAction],
         @ViewBuilder content: () -> Content) {
        self.title = title ?? ""
        self.message = message ?? ""
        self.content = content()
        self.actions = actions
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            
            mainView()
                .background(
                    RoundedRectangle(cornerRadius: 25.0,
                                     style: .continuous)
                        .fill(Color.white
                                .opacity(0.7))
                )
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            
            
        }
    }
    
    @ViewBuilder
    func mainView() -> some View {
        VStack(alignment: .center) {
            Group {
                if showTitle {
                    Text(title)
                        .fontWeight(.bold)
                }
                
                if showMessage {
                    Text(message)
                        .fontWeight(.light)
                        .font(.system(size: 13))
                        .padding(.top, showTitle ? 5 : 0)
                }
            }
            .padding(.horizontal, 20)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            
            content
            
            if !actions.isEmpty {
                Divider()
                GeometryReader { g in
                    ForEach(actions) { action in
                        actionButton(action)
                            .frame(width: calculateWidth(for: g.size))
                            .position(calculatePosition(for: action, size: g.size))
                    }
                }
                .frame(height: buttonHeight)
            }
        }
        .frame(width: 250)
        .padding(.bottom, 10)
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func actionButton(_ action: CustomAlertAction) -> some View {
        HStack {
            Button(action: action.action) {
                HStack {
                    Spacer()
                    Text(action.title)
                        .fontWeight(action.getFontWidth())
                        .foregroundColor(action.getTitleColor())
                    Spacer()
                }
            }
            .frame(height: buttonHeight)
            if actions.last != action {
                GeometryReader { g in
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: g.size.height + 40)
                        .offset(y: -8)
                }
                .frame(width: 0.5)
            }
        }
    }
    
    func calculatePosition(for action: CustomAlertAction, size: CGSize) -> CGPoint {
        let width = calculateWidth(for: size)
        let center = CGPoint(x: width/2, y: size.height/2)
        
        var result: CGPoint = .zero
        
        if let index = actions.firstIndex(of: action) {
            result = center + CGPoint(x: width * CGFloat(index), y: 0.0)
        }
        
        return result
    }
    
    func calculateWidth(for size: CGSize) -> CGFloat {
        size.width / CGFloat(actions.count)
    }
}

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

struct CustomAlert_Previews: PreviewProvider {
    @State static var text = ""
    @State static var isShow = true
    static var previews: some View {
        CustomAlert(title: "Title",
                    message: "Message",
                    actions: [
                        .init(title: "Cancel", type: .cancel, action: {}),
                        .init(title: "Save", type: .default, action: {}),
                        .init(title: "Delete", type: .destructive, action: {})
                    ]) {
            TextField("Введите Email", text: $text)
                .padding(.horizontal, 25)
                .padding(.bottom, 5)
        }
    }
}

struct CustomAlertAction: Identifiable, Equatable {
    
    let id = UUID()
    private let type: CustomAlertType
    let title: String
    let action: (() -> Void)
    
    enum Constant {
        static let cancelColor = Color.blue
        static let defaultColor = Color.blue
        static let destructiveColor = Color.red
    }
    
    init(title: String, type: CustomAlertType, action: @escaping () -> Void) {
        self.title = title
        self.type = type
        self.action = action
    }
    
    func getTitleColor() -> Color {
        switch type {
        case .cancel:
            return Constant.cancelColor
        case .default:
            return Constant.defaultColor
        case .destructive:
            return Constant.destructiveColor
        }
    }
    
    func getFontWidth() -> Font.Weight? {
        switch type {
        case .cancel:
            return .semibold
        case .destructive, .default:
            return nil
        }
    }
    
    static func == (lhs: CustomAlertAction, rhs: CustomAlertAction) -> Bool {
        lhs.id == rhs.id
    }
}

enum CustomAlertType {
    case cancel, `default`, destructive
}
