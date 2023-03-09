//
//  myView.swift
//  load&Save Iamges
//
//  Created by andyhaz on 2/13/23.
//

import Foundation
import Cocoa

class myView: NSView {
    
    var bgColor: NSColor = NSColor.blue
    var myImage = NSImage()
    
    override func draw(_ dirtyRect: NSRect) {
        print("draw")
        // Fill with the current background color.
        // No need to call through to `super` here, since NSView is known to do nothing in its own draw() method.
        bgColor.setFill()
        //load image
        dirtyRect.fill()
    }
    
    func displayImage(){
        let myImageView:NSImageView = NSImageView()
        myImageView.frame.size.width = CGFloat(myImage.size.width)//Image.size.width
        myImageView.frame.size.height = CGFloat(myImage.size.height)//Image.size.height

       // myImage.size.height = myImageView.frame.size.width
       // myImage.size.width =  myImageView.frame.size.height
        
        myImageView.image = myImage
        myImage = myImageView.image!

        self.addSubview(myImageView)
        
        needsDisplay = true
    }
}
