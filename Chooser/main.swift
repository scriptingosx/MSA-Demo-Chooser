//
//  main.swift
//  Chooser
//
//  Created by Armin Briegel on 2021-09-08.
//

import Foundation

let urlScheme = "http"

guard let url = URL(string: "\(urlScheme):") else { exit(1) }

if let cfAppURLs = LSCopyApplicationURLsForURL(url as CFURL, .all) {
    let appURLs = cfAppURLs.takeRetainedValue() as Array
    
    for cfAppURL in appURLs {
        if let appURL = cfAppURL as? URL {
            print(appURL.path)
        }
    }
}

