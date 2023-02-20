//
//  ViewController.swift
//  load&Save Iamges
//
//  Created by andyhaz on 1/17/23.
//

import Cocoa

class ViewController: NSViewController {
    var myImage = NSImage()
    var myImageData:NSImage? = nil
    var LSMData:Array? = []
    
    @IBOutlet weak var myView: myView!
    
    @IBOutlet weak var textOutlet: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textOutlet.stringValue = " hello"
        // Do any additional setup after loading the view.
        LSMData?.append(textOutlet as Any)
        LSMData?.append(myImageData as Any)
    }
    
    @IBAction func SaveFileAction(_ sender: Any) {
       // print(LSMData as Any)
        let lsm = LSManger()
        lsm.fileDataArray = LSMData
        lsm.fileSaveData()
    }
    
    @IBAction func LoadFileAction(_ sender: Any) {
      //  print(LSMData as Any)
        
    }
    
    @IBAction func loadTextAction(_ sender: Any) {
        let lsm = LSManger()
        lsm.fileLoadText()
        textOutlet.stringValue = String(lsm.fileTextData!)
        LSMData![0] = textOutlet.stringValue
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
        LSMData![1] = lsm.fileImageData!
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
