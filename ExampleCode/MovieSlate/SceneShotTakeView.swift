//
//  SceneShotTakeView.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 11/10/20.
//

import SwiftUI

struct SceneShotTakeView : View {
    let geometry:GeometryProxy
    @ObservedObject var model:Model

    var body: some View {
        HStack(alignment: .top) {
            ShotView(title: "SCENE", value: $model.scene, g: geometry).onTapGesture(count: 2) {
                if let number = Int(model.scene) {
                    model.scene = "\(number+1)"
                    model.take = "1"
                    
                    if !model.shot.isEmpty {
                        model.shot = "A"
                    }
                }
            }.frame(width: geometry.size.width/3)
            ShotView(title: "SHOT", value: $model.shot, g: geometry).onTapGesture(count: 2) {
                
                let upperShot = model.shot.uppercased()
                if let lastChar = upperShot.unicodeScalars.last {
                    if lastChar == "Z" {
                        model.shot = "A"
                    } else {
                        let scalarValue = lastChar.value
                        model.shot =
                        String(Character(UnicodeScalar(scalarValue + 1)!))
                    }
                }
                
                model.take = "1"
                
            }.frame(width: geometry.size.width/3)
            ShotView(title: "TAKE", value: $model.take, g: geometry)
                .onTapGesture(count: 2) {
                    if let number = Int(model.take) {
                        model.take = "\(number+1)"
                    }
                }.frame(width: geometry.size.width/3)
            
        }.frame(width: geometry.size.width, height: geometry.size.height * 0.4, alignment: .topLeading)

    }
}
