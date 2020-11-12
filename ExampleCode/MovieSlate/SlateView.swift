//
//  SlateView.swift
//  MovieSlateUITests
//
//  Created by Kurt Niemi on 11/10/20.
//

import SwiftUI

struct SlateView: View {
    @EnvironmentObject var model:Model

    var body: some View {
        GeometryReader { geometry in
            VStack() {                
                SceneShotTakeView(geometry: geometry, model: model).layoutPriority(-1)
                
                Text("PRODUCTION").font(.largeTitle)
                Text(model.fullProductionName).font(.largeTitle).padding()
            Spacer()
            Button(action: {
                model.playSlate()
            }) {  Image(uiImage: UIImage(named: "FreeVector-Sync-Slate")!).resizable().aspectRatio(contentMode: .fit).frame(width: nil, height: geometry.size.height * 0.15, alignment: .center)
            }.buttonStyle(PlainButtonStyle()).layoutPriority(1).padding()
        }
        }
    }
}

struct SlateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environmentObject(Model())
                .previewDevice("iPad Pro (9.7-inch)")
            MainView()
                .environmentObject(Model())
                .previewLayout(.fixed(width: 320, height: 568)) //
            MainView()
                .environmentObject(Model())
                .previewLayout(.fixed(width: 568, height: 320)) // iPhone SE landscape size
        }
    }
}
