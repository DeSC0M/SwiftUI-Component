//
//  SnapCarousel.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 28.08.2020.
//

import SwiftUI

struct SnapCarousel: View {
    
    @State var width = UIScreen.main.bounds.width
    @State var snapOffset: CGFloat = 0
    @State var startPosition: CGFloat = 0
    @State var selectedCard: Int = 0
    
    
    var cardHeight: CGFloat = 300
    var cardWidth: CGFloat = UIScreen.main.bounds.width -  105
    var spacing: CGFloat = 20
    var numberCard = 5
    var mainColor = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    
    var body: some View {
        ZStack {
            mainColor.edgesIgnoringSafeArea(.all)
            
            HStack(alignment: .center, spacing: spacing) {
                ForEach(1...numberCard, id: \.self) { i in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(mainColor)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            .scaleEffect(calculateScale(geometry.frame(in: .global).midX))
                            .animation(Animation.spring().speed(2))
                    }
                    .frame(width: cardWidth)
                }
            }
            .frame(width: width,
                   height: cardHeight)
            .offset(x: calculateOffset(for: numberCard))
            .offset(x: snapOffset)
            .animation(Animation.easeInOut.speed(2))
            .gesture(DragGesture()
                        .onChanged({ (value) in
                            if selectedCard == 0 && value.translation.width > 0 {
                                snapOffset = value.translation.width * (1 - log10(value.translation.width.magnitude/(cardWidth/4)))
                            } else if selectedCard == numberCard-1 && value.translation.width < 0{
                                let temp = value.translation.width * (1 - log10(value.translation.width.magnitude/(cardWidth/4)))
                                snapOffset = startPosition + temp
                            } else {
                                snapOffset = startPosition + value.translation.width
                            }
                        })
                        .onEnded({ (value) in
                            if value.predictedEndTranslation.width.magnitude > width/3 {
                                if value.predictedEndTranslation.width < 0 && selectedCard != numberCard - 1 {
                                    selectedCard += 1
                                    startPosition -= cardWidth + spacing
                                } else if value.predictedEndTranslation.width > 0 && selectedCard != 0 {
                                    selectedCard -= 1
                                    startPosition += cardWidth + spacing
                                }
                            }
                            snapOffset = startPosition
                        })
        )
        }
    }
    
    func calculateOffset(for cards: Int) -> CGFloat {
        let totalWidth = CGFloat(cards) * (cardWidth + spacing) - spacing
        let offset = (totalWidth) / 2 - cardWidth / 2
        
        return offset
    }
    
    func calculateScale(_ centerX: CGFloat) -> CGFloat {
        if centerX < width/2 {
            return (width/2 - centerX) < cardWidth/2 + spacing/2 ? 1.1 : 0.9
        } else {
            return (centerX - width/2) < cardWidth/2 + spacing/2 ? 1.1 : 0.9
        }
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        SnapCarousel()
    }
}
