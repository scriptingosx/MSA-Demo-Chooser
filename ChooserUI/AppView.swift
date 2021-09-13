//
//  AppView.swift
//  AppView
//
//  Created by Armin Briegel on 2021-09-10.
//

import SwiftUI

struct AppView: View {
  var app: LSApp
  @Binding var selection: LSApp?
  
  var body: some View {
    VStack {
      Image(nsImage: app.icon)
        .resizable(resizingMode: .stretch)
        .frame(width: 120.0, height: 120.0)
      Text(app.name)
    }
    .background(Color((app == selection) ? .controlAccentColor : .windowBackgroundColor))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .onTapGesture {
      selection = app
    }
  }
}

struct AppView_Previews: PreviewProvider {
  
  static let safari = LSApp(url: URL(fileURLWithPath: "/Applications/Safari.app"))!
  static let firefox = LSApp(url: URL(fileURLWithPath: "/Applications/Firefox.app"))!
  
  @State static var selectedApp: LSApp? = safari
  
  static var previews: some View {
    AppView(app: safari, selection: $selectedApp)
    AppView(app: firefox, selection: $selectedApp)
  }
}
