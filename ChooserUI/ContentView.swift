//
//  ContentView.swift
//  ChooserUI
//
//  Created by Armin Briegel on 2021-09-10.
//

import SwiftUI

struct ContentView: View {
  let apps = LSKit.applications(for: "http")
  
  var body: some View {
    VStack {
      ForEach(apps) { app in
        Text(app.name)
      }
    }.padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
