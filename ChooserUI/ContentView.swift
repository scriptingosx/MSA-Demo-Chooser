//
//  ContentView.swift
//  ChooserUI
//
//  Created by Armin Briegel on 2021-09-10.
//

import SwiftUI

struct ContentView: View {
  let appURLs = LSKit.urls(for: "http")
  
  var body: some View {
    VStack {
      ForEach(appURLs, id: \.self) { appURL in
        Text(appURL.path)
      }
    }.padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
