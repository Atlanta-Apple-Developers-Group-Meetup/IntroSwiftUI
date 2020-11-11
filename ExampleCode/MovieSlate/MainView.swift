//
//  MainView.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 10/15/20.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var model:Model
    var body: some View {
        TabView {
            SlateView(model: model).tabItem { Image(systemName: "film")
                Text("Slate")
            }
            SceneView(model: model).tabItem { Image(systemName: "square.and.pencil")
                Text("Scene Entering")
            }
        }
    }
}
