//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import UIKit

// MARK: - WonderResources Fonts
extension WonderResources.Fonts {
    // MARK: - Comics
    public struct Comics {
        public enum Traits: String {
            case SemiBold = "MavenPro-SemiBold"
            case Medium = "MavenPro-Medium"
            case Bold = "MavenPro-Bold"
            case Regular = "MavenPro-Regular"
            case ExtraBold = "MavenPro-ExtraBold"
            case Black = "MavenPro-Black"
        }
        
        public static func get(_ trait: Traits, size: CGFloat) -> UIFont? {
            loadCustomFonts(for: "ttf") ? UIFont(name: "\(trait.rawValue)", size: size) : UIFont.systemFont(ofSize: 0.0)
        }
        
        private static func loadCustomFonts(for fontExtension: String) -> Bool {
            let fileManager = FileManager.default
            let bundleURL = Bundle.module.bundleURL
            do {
                let contents = try fileManager.contentsOfDirectory(at: bundleURL, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
                for url in contents {
                    if url.pathExtension == fontExtension {
                        guard let fontData = NSData(contentsOf: url) else {
                            continue
                        }
                        guard let provider = CGDataProvider(data: fontData),
                              let font = CGFont(provider) else { fatalError() }
                        
                        CTFontManagerRegisterGraphicsFont(font, nil)
                    }
                }
            } catch {
                print("error: \(error)")
            }
            return true
        }
    }
}
