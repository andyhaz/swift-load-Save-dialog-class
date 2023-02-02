//
//  ViewController.swift
//  load&Save Iamges
//
//  Created by andyhaz on 1/17/23.
//

import Cocoa

class ViewController: NSViewController {
    var myImage = NSImage()

    //
    @IBOutlet weak var imageWell: NSImageView!

    @IBOutlet weak var myView: NSView!
    
    var myImageData:NSImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loadAction(_ sender: Any) {
        let lsm = LSManger()
        lsm.fileLoadText()
       // lsm.fileLoadImage()
      //  myImageData = lsm.fileImageData!
        //print(lsm.filePath as Any)
       // print("loadAction: \(String(describing: lsm.fileImageData))")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let lsm = LSManger()
      //  lsm.fileSaveImage(imgData: myImageData!)
        lsm.fileSaveText(textData: "here some text:hello world")
        print(lsm.filePath as Any)
        print("save\(myImage)")
   // myurl:url?
       // saveImageInDocumentDirectory(image: myImage, fileName: "test.png")
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
