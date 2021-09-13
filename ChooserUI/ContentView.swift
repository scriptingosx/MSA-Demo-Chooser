//
//  ContentView.swift
//  ChooserUI
//
//  Created by Armin Briegel on 2021-09-10.
//

import SwiftUI

struct ContentView: View {
  let apps = LSKit.applications(for: "http")
  let selectedApp = LSKit.defaultApplication(for: "http")
  
  var body: some View {
    HStack {
      ForEach(apps) { app in
        AppView(app: app, selection: selectedApp)
      }
    }.padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
