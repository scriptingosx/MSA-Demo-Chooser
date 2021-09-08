//
//  LSKit.swift
//  LSKit
//
//  Created by Armin Briegel on 2021-08-30.
//

import Foundation

class LSKit {
    
    /**
     returns a list of URLs to applications that can open URLs starting with the scheme
     - Parameter scheme: url scheme (excluding the `:` or `/`, e.g. `http`)
    */
     static func urls(for scheme: String) -> [URL] {
        var urlList = [URL]()
        guard let url = URL(string: "\(scheme):") else { return urlList }
        if let result = LSCopyApplicationURLsForURL(url as CFURL, .all) {
            let cfURLList = result.takeRetainedValue() as Array
            for item in cfURLList {
                if let appURL = item as? URL {
                    urlList.append(appURL)
                }
            }
        }
        return urlList
    }
    
    /**
     returns URL to the default application for URLs starting with scheme
     - Parameter scheme: url scheme (excluding the `:` or `/`, e.g. `http`)
     - Returns: urls to default application
     */
    static func defaultURL(for scheme: String) -> URL? {
        guard let url = URL(string: "\(scheme):") else { return nil }
        if let result = LSCopyDefaultApplicationURLForURL(url as CFURL, .all, nil) {
            let appURL = result.takeRetainedValue() as URL
            return appURL
        }
        return nil
    }
    
    /**
     set the default app for scheme to the app with the identifier
     - Parameters:
        - identifier: bundle id of the new default application
        - scheme:url scheme (excluding the `:` or `/`, e.g. `http`)
     - Returns: OSStatus (discardable)
     */
    @discardableResult static func setDefault(identifier: String, for scheme: String) -> OSStatus {
        return LSSetDefaultHandlerForURLScheme(scheme as CFString, identifier as CFString)
    }
}


