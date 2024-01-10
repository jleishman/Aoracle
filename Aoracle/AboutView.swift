//
//  AboutView.swift
//  Aoracle
//
//  Created by Justin Leishman on 11/19/23.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
            Text("About Aoracle Detail").font(.title)
            .padding()
            
            Spacer()
            
            Button("Book Link Text") {
                openURL(URL(string: "https://books.apple.com/us/book/quantum-computing-since-democritus/id812176165")!)
            }
    }
}

#Preview {
    AboutView()
}
