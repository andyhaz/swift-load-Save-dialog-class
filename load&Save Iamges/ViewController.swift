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

    @IBOutlet weak var myView: myView!
    
    @IBOutlet weak var textOutlet: NSTextField!
    
    var myImageData:NSImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOutlet.stringValue = " hello"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loadTextAction(_ sender: Any) {
        let lsm = LSManger()
        lsm.fileLoadText()
        textOutlet.stringValue = String(lsm.fileTextData!)
        
    }
    
    @IBAction func saveTextAction(_ sender: Any) {
        let lsm = LSManger()
        let txt:String = textOutlet.stringValue
        lsm.fileSaveText(textData:txt)
    }
    
    @IBAction func loadAction(_ sender: Any) {
        let lsm = LSManger()
 
        lsm.fileLoadImage()
        myView.myImage =  lsm.fileImageData!
        myView.displayImage()
        //print(lsm.filePath as Any)
       // print("loadAction: \(String(describing: lsm.fileImageData))")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let lsm = LSManger()
      //  lsm.fileSaveImage(imgData: myImageData!)
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
