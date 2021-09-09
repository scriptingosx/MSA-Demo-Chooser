//
//  main.swift
//  Chooser
//
//  Created by Armin Briegel on 2021-09-08.
//

import Foundation

let arguments = CommandLine.arguments.dropFirst()

guard let urlScheme = arguments.first else {
    print("usage: chooser <urlscheme>")
    exit(1)
}

let appURLs = LSKit.urls(for: urlScheme)

for appURL in appURLs {
    print(appURL.path)
}

