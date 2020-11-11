//
//  ShotView.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 10/18/20.
//

import SwiftUI

struct ShotView: View {
    let title:String
    @Binding var value:String
    let g:GeometryProxy
    let fontAdjustmentRatio:CGFloat = 0.1
    
    var body: some View {
            VStack {
                Text("\(title)").font(.system(size: g.size.width * fontAdjustmentRatio))
                Text("\(value)").font(.system(size: g.size.width * fontAdjustmentRatio))
            }
    }
    
}

struct ShotPreviewView : View {
    @State var shot:String = "1"
    
    var body: some View {
        GeometryReader { g in
            VStack {
            ShotView(title: "SHOT", value: $shot, g: g)
            }
        }
    }
}

struct ShotView_Previews:
    PreviewProvider {
    
    static var previews: some View {
        ShotPreviewView()
    }
}
