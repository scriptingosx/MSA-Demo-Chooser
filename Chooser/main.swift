//
//  main.swift
//  Chooser
//
//  Created by Armin Briegel on 2021-09-08.
//

import Foundation

let urlScheme = "http"

let appURLs = LSKit.urls(for: urlScheme)

for appURL in appURLs {
    print(appURL.path)
}

