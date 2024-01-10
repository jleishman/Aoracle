//
//  ContentView.swift
//  Aoracle
//
//  Created by Justin Leishman on 11/13/23.
//

import SwiftUI

struct OracleView: View {
    @StateObject private var model = OracleViewModel()
    
    var body: some View {
        Spacer()
        
        if let percentage = model.predictionPercentage {
            Text("\(percentage.formatted(.number.precision(.fractionLength(0))))% Correctly Predicted")
                .font(.largeTitle)
        } else {
            Text("Keep tapping")
                .font(.largeTitle)
        }
        
        #if os(iOS)
        Rectangle().fill(.clear)
        #endif

        HStack {
            Button(action: {
                model.append(.blue)
            }, label: {
                RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.blue)
            })
            .buttonStyle(.borderless)
            .focusable(false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .keyboardShortcut(KeyEquivalent("b"), modifiers: [])
            
            Spacer()
            
            Button(action: {
                model.append(.green)
            }, label: {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.green)
            })
            .buttonStyle(.borderless)
            .focusable(false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .keyboardShortcut(KeyEquivalent("g"), modifiers: [])
        }
        .padding([.leading, .trailing, .bottom], 10)
        
        #if os(iOS)
        Rectangle().fill(.clear)
        #endif
        
        VStack {
            Spacer()
            
            Button {
                model.reset()
            } label: {
                Text("Reset")
            }
         
            Spacer()
            
            NavigationLink("About Aoracle") {
                AboutView()
            }.focusable(false)
            
            Spacer()
        }
    }
}

#Preview {
    OracleView()
}

