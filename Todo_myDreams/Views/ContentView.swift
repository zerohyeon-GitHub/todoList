//
//  ContentView.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/30.
//

import SwiftUI

struct ContentView: View {
  @State var selectedColor = "color"
  var colors = ["red", "green", "blue"]
  
  var body: some View {
    VStack {
      Text("You selected: \(selectedColor)")
      
      Picker("Choose a color", selection: $selectedColor) {
        ForEach(colors, id: \.self) {
          Text($0)
        }
      }
      .pickerStyle(.menu)
      .padding()
      .background(.yellow)
      .cornerRadius(15)
      .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
