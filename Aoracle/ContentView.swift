//
//  ContentView.swift
//  Aoracle
//
//  Created by Justin Leishman on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) private var openURL
        
    @StateObject private var model = ContentViewModel()
    
    var body: some View {
        Spacer()
        
        if let percentage = model.predictionPercentage {
            Text("\(percentage.formatted(.number.precision(.fractionLength(0))))% Correctly Predicted")
                .font(.largeTitle)
        } else {
            Text("Keep tapping")
                .font(.largeTitle)
        }
        
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
                RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.green)
            })
            .buttonStyle(.borderless)
            .focusable(false)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .keyboardShortcut(KeyEquivalent("g"), modifiers: [])
        }
        .padding([.leading, .trailing, .bottom], 10)
        
        Button("About the Aaronson Oracle") {
            openURL(URL(string: "https://duckduckgo.com/?q=aaronson+oracle")!)
        }
        .buttonStyle(.borderless)
        .focusable(false)
        
        Spacer()
    }    
}

#Preview {
    ContentView()
}

