//
//  ContentView.swift
//  GridExample
//
//  Created by Kurt Niemi on 11/11/20.
//

import SwiftUI

struct BartView: View {
    let text:String
    var body: some View {
        VStack {
            Image("Bart").resizable().aspectRatio(contentMode: .fit)
            Text(text)
        }
    }
}

struct ContentView: View {
    let data = (1...1000).map { "Item \($0)" }

    // Comment out - and replace columns to see different layouts
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

/*
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
*/
/*
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
*/

/*     let columns = [
         GridItem(.fixed(100)),
         GridItem(.flexible()),
     ]
*/
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    BartView(text:item)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
