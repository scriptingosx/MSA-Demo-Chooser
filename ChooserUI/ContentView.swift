//
//  ContentView.swift
//  ChooserUI
//
//  Created by Armin Briegel on 2021-09-10.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("urlScheme") static var urlScheme = "http"
  
  let apps = LSKit.applications(for: urlScheme)
  @State var selectedApp = LSKit.defaultApplication(for: urlScheme)
  
  var body: some View {
    VStack {
      HStack {
        ForEach(apps) { app in
          AppView(app: app, selection: $selectedApp)
        }
      }.padding()
      Button(action: {
        if let id = selectedApp?.id {
          LSKit.setDefault(identifier: id, for: ContentView.urlScheme)
          NSApp.terminate(self)
        }
      }) {
        Text("Set Default…")
      }
      .padding(10.0)
      .keyboardShortcut(/*@START_MENU_TOKEN@*/.defaultAction/*@END_MENU_TOKEN@*/)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
