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
    }
    
    func crop(nsImage: NSImage,rect: CGRect) -> NSImage {
        let cgImage = (nsImage.cgImage(forProposedRect: nil, context: nil, hints: nil)?.cropping(to: rect))!

        let size = NSSize(width: rect.width, height: rect.height)
        return NSImage(cgImage: cgImage, size: size)
    }
    
    
    func fileSaveDiskImage(filePath:String) {
        
        let rep: NSBitmapImageRep! = self.bitmapImageRepForCachingDisplay(in: self.bounds)
        rep.pixelsWide = Int(rep.size.width)
        rep.pixelsHigh = Int(rep.size.height)
        self.cacheDisplay(in: self.bounds, to: rep!)
        let imageData: Data! = rep!.representation(using: NSBitmapImageRep.FileType.png, properties: [:])
        
        print("imasge Data: \(String(describing: rep!))")

        let fileURL = URL(fileURLWithPath:filePath)

        do {
            try imageData.write(to: fileURL, options: .atomic)
        }
        catch {
            print("save file error: \(error)")
        }
    }
    
    func resizeImage(imageData:NSImage,width:Int,height:Int){
        print("image width\(imageData.size.width)")
        print("image height:\(imageData.size.width)")
        print("width:\(width)")
        print("height:\(height)")
        print("imagedata\(imageData)")

        let myImageView:NSImageView = NSImageView()
      //  self.changeBackgroundColor(color: .green)
        self.setFrameSize(NSSize(width: width, height: height))
        
        imageData.size.width = CGFloat(width)
        imageData.size.height = CGFloat(height)
        myImageView.frame.size.width = CGFloat(width)//Image.size.width
        myImageView.frame.size.height = CGFloat(height)//Image.size.height
        myImageView.image = imageData
        print("imagedata end:\(imageData)")

        self.addSubview(myImageView)
        
      //  needsDisplay = true
    }
  
    func displayImage(imageWidth:Float,imageHeight:Float){
        let myImageView:NSImageView = NSImageView()
        myImageView.frame.size.width = CGFloat(imageWidth)//Image.size.width
        myImageView.frame.size.height = CGFloat(imageHeight)//Image.size.height
        
        myImage.size.width = CGFloat(imageWidth)//Image.size.width
        myImage.size.height = CGFloat(imageHeight)//Image.size.height
        myImageView.image = myImage
        myImage = myImageView.image!

        self.addSubview(myImageView)
        
        needsDisplay = true
    }
    
    func loadImageView(fileName:String,FileWidth:Float,fileHeight:Float) {
        /* Create an image view */
        if let Image = NSImage(contentsOfFile: fileName){
           //  print("image size \(imageData.size.width):\(imageData.size.height)")
           // let Image = NSImage(named: "grsLogo.png")
            let myImageView:NSImageView = NSImageView()
            myImageView.frame.size.width = CGFloat(FileWidth)//Image.size.width
            myImageView.frame.size.height = CGFloat(fileHeight)//Image.size.height
            myImageView.frame.origin.x = 100
            myImageView.frame.origin.y = 10
            myImageView.image = Image
            myImage = myImageView.image!
          //  print("image:\(myImage.size)")
            
            self.addSubview(myImageView)
        } else {
            print("error")
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
/*
     func resizeImage(imageData:NSImage, imageWidth:Float,imageHeight:Float)->NSImage{
         let myImageView:NSImageView = NSImageView()

         imageData.size.width = CGFloat(imageWidth)//Image.size.width
         imageData.size.height = CGFloat(imageHeight)//Image.size.height
         
         myImageView.frame.size.width = CGFloat(imageWidth)//Image.size.width
         myImageView.frame.size.height = CGFloat(imageHeight)//Image.size.height
         myImageView.image = imageData
        // myImage = myImageView.image!
         
         print("draw:imageData:\(imageData)")
         
         return imageData
     }
*/
