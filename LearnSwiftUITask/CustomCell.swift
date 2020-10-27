//
//  CustomCell.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 28.08.2020.
//

import SwiftUI

struct CustomCell: View {
    @State var yOffset: CGFloat = 0
    
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            HStack {
                Text("My Custom Cell")
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.all, 20)
            .background(Color.black)
            .offset(x: yOffset)
            .background(yOffset > 0 ? Color.yellow : Color.blue)
            .cornerRadius(20)
            .padding(.all, 5)
            .gesture(DragGesture()
                        .onChanged({ (value) in
                            withAnimation {
                                yOffset = value.translation.width
                            }
                        })
                        .onEnded({ _ in
                            withAnimation {
                                yOffset = 0
                            }
                        })
            )
        })
            
        
    
    }
}

struct ListWithCell: View  {
    
    @State var data = [
        Cell(offset: 0),
        Cell(offset: 0),
        Cell(offset: 0),
        Cell(offset: 0),
        Cell(offset: 0),
        Cell(offset: 0),
        Cell(offset: 0),
        Cell(offset: 0)
    ]
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(data) { index in
                    CustomCell()
                }
            }
        }
    }
    
    func getData(id: UUID) -> Int {
        for i in 0...data.count {
            if data[i].id == id {
                return i
            }
        }
        return 0
    }
}



struct Cell: Identifiable {
    var id = UUID()
    var offset: CGFloat
}

struct CustomCell_Previews: PreviewProvider {
    static var previews: some View {
        ListWithCell()
    }
}
