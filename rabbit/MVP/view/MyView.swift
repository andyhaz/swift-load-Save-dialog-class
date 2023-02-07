//
//  MyView.swift
//  nsviewSwift
//
//  Created by andyhaz on 10/11/22.
//

import Foundation
import Cocoa

// Use an initial uppercase letter for class and other type names.
// This avoids a class with a variable name using a lowercase letter
// (such as the @IBOutlet in ViewController.swift).
class MyView: NSView {
    // MARK: - Variables
    var bgColor: NSColor = NSColor.gridColor
    var myImage = NSImage()
    
    override func draw(_ dirtyRect: NSRect) {
        print("draw")
        // Fill with the current background color.
        // No need to call through to `super` here, since NSView is known to do nothing in its own draw() method.
        bgColor.setFill()
        //load image
        dirtyRect.fill()
       // loadImageView(fileName:"grsLogo.png", FileWidth: 100, fileHeight: 100)
    }
    
    func loadImageView(fileName:String,FileWidth:Float,fileHeight:Float) {
        /* Create an image view */
        if let Image = NSImage(contentsOfFile: fileName){
           //  print("image size \(imageData.size.width):\(imageData.size.height)")
           // let Image = NSImage(named: "grsLogo.png")
            let myImageView:NSImageView = NSImageView()
            myImageView.frame.size.width = CGFloat(FileWidth)//Image.size.width
            myImageView.frame.size.height = CGFloat(fileHeight)//Image.size.height

            myImageView.image = Image
            myImage = myImageView.image!
            self.addSubview(myImageView)
        }
        needsDisplay = true
    }
    
    func clearView(){
        let theSubviews : Array<NSView> = self.subviews as Array<NSView>
        for view in theSubviews {
            view.removeFromSuperview()
        }
       // self.removeFromSuperview()
    }
    
    func changeBackgroundColor(color: NSColor) {
        // Remember the new background color, and force the view to redraw.
        bgColor = color
        needsDisplay = true
    }
}
/*
 public static func saveImageInDocumentDirectory(image: UIImage, fileName: String) -> URL? {
         
         let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
         let fileURL = documentsUrl.appendingPathComponent(fileName)
         if let imageData = UIImagePNGRepresentation(image) {
             try? imageData.write(to: fileURL, options: .atomic)
             return fileURL
         }
         return nil
     }
 
 public static func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
         
         let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
         let fileURL = documentsUrl.appendingPathComponent(fileName)
         do {
             let imageData = try Data(contentsOf: fileURL)
             return UIImage(data: imageData)
         } catch {}
         return nil
     }
 */
