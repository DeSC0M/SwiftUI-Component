//
//  WaveView.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 30.08.2020.
//

import SwiftUI

struct Home: View {
    
    @State var isShowLoadingView = false
    @State var isDataHasLoading = true
    @State var isDisableButton = false
    @State var imageOpasity: Double = 0
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            
            LinearGradient(gradient: Gradient(colors: [.red, .green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .mask(
                    Text("Loading Progress")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .frame(alignment: .center)
                )
                .frame(height: 50)
                .padding()
                .background(Color.black)
                .shadow(radius: 50)
            
            
            
            Spacer(minLength: 20)
            if isDataHasLoading {
            Circle().fill(Color.blue.opacity(0.75))
                    .background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 180, height: 180)
                    .padding(.all, 10)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 8.0)
                            .foregroundColor(Color.green)
                    )
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .mask(Image(systemName: "ant.circle")
                                    .resizable())
                            .padding(.all, 50)
                            .opacity(imageOpasity)
                    )
                    .shadow(radius: 10)
                    .onAppear(perform: {
                        imageOpasity = 0
                        withAnimation(.linear) {
                            imageOpasity = 1
                        }
                    })
            } else {
                WaveView(isLoadingEnd: $isDataHasLoading, isDisableButton: $isDisableButton)
                    .frame(width: 200, height: 200)
            }
            
            Spacer(minLength: 20)
            Button(action: {
                isDataHasLoading = false
                
            }, label: {
                Text("Loading data")
                    .font(.title)
                    .fontWeight(.black)
                    .padding(.all, 25)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(isDisableButton ? 0.5  : 1))
                    .clipShape(Capsule())
                    .shadow(radius: 5)
            })
            .disabled(isDisableButton)
            Spacer(minLength: 20)
        }
    }
}

struct WaveView: View {
    
    @State var progress1: CGFloat = 0
    @State var progress2: CGFloat = 0
    @State var waveOffset1: CGFloat = 0
    @State var waveOffset2: CGFloat = 0
    @State var width = UIScreen.main.bounds.width
    @Binding var isLoadingEnd: Bool
    @Binding var isDisableButton: Bool
    
    var body: some View {
        ZStack {
            Wave(progress: progress1)
                .offset(x: -waveOffset1)
            Wave(progress: progress2)
                .offset(x: -waveOffset2)
        }
        .frame(width: width * 2)
        .opacity(0.5)
        .edgesIgnoringSafeArea(.all)
        .offset(x: width/2, y: 50)
        .background(Color.white)
        .clipShape(Circle())
        .padding(.all, 10)
        .overlay(
            Circle()
                .stroke(lineWidth: 8.0)
                .foregroundColor(progress1 == 1 ? Color.green : Color.gray)
        )
        .shadow(radius: 10)
        .onAppear(perform: {
            withAnimation {
                isDisableButton = true
            }
            
            
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                waveOffset1 = UIScreen.main.bounds.width
            }
            
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                waveOffset2 = UIScreen.main.bounds.width
            }
            
            withAnimation(Animation.linear(duration: 7)) {
                progress1 = 1
                progress2 = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                isLoadingEnd = true
                withAnimation {
                    isDisableButton = false
                }
            }
        })
    }
}

struct Wave: View {
    var progress: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            Color.blue
                .clipShape(WaveShape(progress: progress))
            Color.blue
                .clipShape(WaveShape(progress: progress))
        }
    }
}

struct WaveShape: Shape {
    
    var progress: CGFloat
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            let h = rect.height - progress * (rect.height + 50)
            
            path.move(to: .init(x: rect.minX, y: rect.maxY))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            path.addLine(to: .init(x: rect.maxX, y: h))
            path.addCurve(to: .init(x: rect.minX, y: h),
                          control1: .init(x: rect.maxX/2, y: h + 50),
                          control2: .init(x: rect.maxX/2, y: h - 50))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
            
        }
    }
}


struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
