//
//  main.swift
//  Chooser
//
//  Created by Armin Briegel on 2021-09-08.
//

import Foundation
import ArgumentParser

struct Chooser: ParsableCommand {
    @Argument var urlScheme: String
    
    func run() {
        let appURLs = LSKit.urls(for: urlScheme)

        for appURL in appURLs {
            print(appURL.path)
        }

    }
}

Chooser.main()
