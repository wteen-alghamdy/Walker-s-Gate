//
//  ContentView.swift
//  Walker's-Gate
//
//  Created by Wteen Alghamdy on 13/08/1447 AH.
//المجمع الرئيسي. يضع الخريطة كطبقة أساسية، وفوقها عداد الطاقة، دائرة النقاط، وزر التوب 3.


import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // استدعاء الخريطة
            MapViewRepresentable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Walker's Gate")
                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(12)
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 20)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
