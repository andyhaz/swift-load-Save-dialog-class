//
//  saveImageFile.swift
//  rabbit
//
//  Created by andyhaz on 3/9/23.
//

import Foundation
import Cocoa

class processImage:NSView {
     
    func saveToDisk() {
        let rep: NSBitmapImageRep! = self.bitmapImageRepForCachingDisplay(in: self.bounds)
        self.cacheDisplay(in: self.bounds, to: rep!)
        let imageData: Data! = rep!.representation(using: NSBitmapImageRep.FileType.png, properties: [:])

        let fileManager = FileManager.default
        let desktopPath = try! fileManager.url(for: .desktopDirectory, in: .allDomainsMask, appropriateFor: nil, create: true)
        let filePath = desktopPath.appendingPathComponent("test.png")
        do {
            try imageData.write(to: filePath, options: .atomic)
        }
        catch {
            print("save file error: \(error)")
        }
    }
}
