//
//  SceneView.swift
//  MovieSlate
//
//  Created by Kurt Niemi on 10/18/20.
//

import SwiftUI

struct SceneEntryView : View {
    let label:String
    let placeholderText:String = "Enter value..."
    @Binding var enteredValue:String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.callout)
                .bold()
            TextField(placeholderText, text: $enteredValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct SceneView: View {
    @EnvironmentObject var model:Model
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SceneEntryView(label: "Scene", enteredValue: $model.scene)
                SceneEntryView(label: "Shot", enteredValue: $model.shot)

                Text("Take")
                    .font(.callout)
                    .bold()
                TextField("Enter take...", text: $model.take)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Production Name")
                    .font(.callout)
                    .bold()
                TextField("Enter name...", text: $model.productionName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Season")
                    .font(.callout)
                    .bold()
                TextField("Enter season...", text: $model.season)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SceneEntryView(label: "Episode", enteredValue: $model.episode)

                }
        }.padding().keyboardAware()

    }
}
