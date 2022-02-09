//
//  ContentView.swift
//  MetrixEffect
//
//  Created by Rohidul Islam on 6/2/22.
//

import SwiftUI

struct MetrixRainView: View {
    var body: some View {
        ZStack{
            Color.black
            GeometryReader{proxy in
                let size = proxy.size
                
                HStack{
                    ForEach(0..<Int(size.width/25)){index in
                        MetrixRainCol(size: size)
                    }
                }.opacity(0.5)
                HStack{
                    ForEach(0..<Int(size.width/25)){index in
                        MetrixRainCol(size: size)
                    }
                }.offset(x: 12.5)
            }
        }.ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

struct MetrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        MetrixRainView()
    }
}


let metrixCharectors: String = "abcdefghijklmnopqrstuvwxyzabcdefghizasdfasd"

struct MetrixRainCol: View {
    @State private var begainAnimation: Bool = false;
    @State private var randomIndex: Int = 0
    let size: CGSize
    var body: some View {
        VStack{
            ForEach(0..<metrixCharectors.count, id: \.self){index in
                let charactor = Array(metrixCharectors)[getRandomCharIndex(index: index)]
                Text(String(charactor))
                    .foregroundColor(Color.green)
                    .font(.custom("matrix", size: 25))
            }
        }
        .mask(alignment: .top){
            Rectangle().fill(LinearGradient(colors: [
                .clear,
                .black.opacity(0.1),
                .black.opacity(0.2),
                .black.opacity(0.3),
                .black.opacity(0.5),
                .black.opacity(0.6),
                .black.opacity(0.8),
            ], startPoint: .top, endPoint: .bottom))
                .offset(y: begainAnimation ? size.height : -size.height)
        }
        .onAppear {
            withAnimation(.linear(duration: 12).delay(Double.random(in: 0..<10)).repeatForever(autoreverses: false)){
                begainAnimation = true
            }
        }
        .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
            randomIndex = Int.random(in: 0..<metrixCharectors.count)
        }
    }
    
    func getRandomCharIndex(index: Int) -> Int {
        let maxCount = metrixCharectors.count - 1
        
        if randomIndex + index >  maxCount {
            if index - randomIndex < 0 {
                return index
            }
            return index  - randomIndex
        }else{
            return randomIndex + index
        }
    }
}
