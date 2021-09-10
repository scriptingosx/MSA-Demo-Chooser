//
//  LSApp.swift
//  LSApplication
//
//  Created by Armin Briegel on 2021-08-30.
//

import AppKit


/**
 An LSApp object represents an application on disk for use this with the LSKit functions.
 */
struct LSApp : Identifiable {
    /** local file URL of the app*/
    let url: URL
    
    /** the app's bundle object*/
    let bundle: Bundle
    
    /** app bundle identifier */
    let identifier: String
    
    /** app name (from bundle)*/
    let name: String
    
    /** path to the app */
    var path: String {
        return url.path
    }
    
    /** returns the identifier */
    var id: String {
        return identifier
    }
    
    /** app icon (256x256) */
    var icon: NSImage {
        let icon = NSWorkspace.shared.icon(forFile: url.path)
        icon.size = NSSize(width: 256.0, height: 256.0)
        return icon
    }
    
    /** returns whether the app is the default handler for the url scheme */
    func isDefault(for scheme: String) -> Bool {
        return LSKit.defaultURL(for: scheme) == self.url
    }
    
    /**
     default initializer
     - Parameter url: local file URL to the application
     */
    init?(url: URL) {
        self.url = url
        guard let newBundle = Bundle(url: url) else { return nil }
        self.bundle = newBundle
        self.identifier = self.bundle.bundleIdentifier ?? ""
        self.name = self.bundle.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}

/**
 adds functions to LSKit that return LSApp objects instead of URLs
 */
extension LSKit {
    /**
     gets a list of applications for the given url Scheme
     - Parameter for: the url scheme (e.g. "http")
     - Returns: Array of LSApp objects
     */
    static func applications(for scheme: String) -> [LSApp] {
        var applicationList = [LSApp]()
        let urlList = urls(for: scheme)
        for appURL in urlList {
            if let newApp = LSApp(url: appURL) {
                applicationList.append(newApp)
            }
        }
        return applicationList
    }
    
    /**
     gets the default application for the give URL scheme
     - Parameter for: the url scheme (e.g. "http")
     - Returns: the default application as an LSApp
     */
    static func defaultApplication(for scheme: String) -> LSApp? {
        if let defaultAppURL = defaultURL(for: scheme) {
            return LSApp(url: defaultAppURL)
        } else {
            return nil
        }
    }
}

/**
 extends LSKit with functions that read the urlScheme from CFPreferences/NSUserDefaults/@AppStorage
 */
extension LSKit {
    /**
     preference key for the urlScheme
     */
    static let urlSchemeKey = "urlScheme"
    
    /**
    convenience accessor for the default scheme setting
     - Returns: default url scheme
     */
    static func defaultScheme() -> String {
        return UserDefaults.standard.string(forKey: urlSchemeKey) ?? "http"
    }
    
    /**
     convenience accessor for all applications for the default URL scheme
     - Returns: Array of LSApp objects
     */
    static func applications() -> [LSApp] {
        return applications(for: defaultScheme())
    }
    
    /**
     convenience accessor for default app for the default URL scheme
     - Returns: default app as LSApp
     */
    static func defaultApplication() -> LSApp? {
        return defaultApplication(for: defaultScheme())
    }
}

