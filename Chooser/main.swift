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
            subcommands: [List.self, Default.self, Set.self],
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
    
    struct Set: ParsableCommand {
        @Argument var urlScheme: String
        @Argument var identifier: String
        
        func run() {
            let result = LSKit.setDefault(identifier: identifier, for: urlScheme)
            
            if result == 0 {
                print("set \(identifier) for \(urlScheme)")
            } else {
                print("cannot set default app for \(urlScheme) (error \(result))")
            }
        }
    }
}

Chooser.main()
