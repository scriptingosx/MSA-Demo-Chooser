//
//  main.swift
//  Chooser
//
//  Created by Armin Briegel on 2021-09-08.
//

import Foundation
import ArgumentParser

struct Chooser: ParsableCommand {
    static var configuration = CommandConfiguration(
            abstract: "Read and set default URL scheme handlers.",
            subcommands: [List.self, Default.self],
            defaultSubcommand: List.self)

    struct List: ParsableCommand {
        @Argument var urlScheme: String
        
        func run() {
            let appURLs = LSKit.urls(for: urlScheme)

            for appURL in appURLs {
                print(appURL.path)
            }
        }
    }
    
    struct Default: ParsableCommand {
        @Argument var urlScheme: String
        
        func run() {
            let appURL = LSKit.defaultURL(for: urlScheme)
            print(appURL?.path ?? "no default app found")
        }
    }
}

Chooser.main()
