//
//  MainView.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 10/15/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SlateView().tabItem { Image(systemName: "film")
                Text("Slate")
            }
            SceneView().tabItem { Image(systemName: "square.and.pencil")
                Text("Scene Entering")
            }
        }
    }
}
