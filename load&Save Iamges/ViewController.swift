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
        lsm.fileLoadImage()
        myImageData = lsm.fileImageData!
        print(lsm.filePath as Any)
        print("loadAction: \(String(describing: lsm.fileImageData))")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let lsm = LSManger()
        lsm.fileSaveImage(imgData: myImageData!)
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

class LSManger{
    
    var filePath:String? = nil
    var fileImageData:NSImage? = nil
    var fileTextData:String? = nil
    var fileNameData:String? = nil
    
    func fileSaveImage(imgData:NSImage){
      //  let image = NSImage()
        saveDialog(titleBar: "save image")
        fileImageData = imgData
        if filePath != nil {
           // let fileNameExt =
           // let image = fileImageData
           // var newfileName = filePath?.appending(".png")
            saveImageInDirectory(fileName: fileNameData!, imageData: imgData, fileEtx: "png")
            print("save image")
           // self.scaleImage(image: image!)
        } else {
            print(fileImageData as Any)
        }
    }
    
    func fileLoadImage(){
        loadDialog(titleBar: "Load Image")
        //load image
        fileImageData = NSImage(contentsOfFile: filePath!)!
        print("load image:\(String(describing: fileImageData))")
    }
    
    func fileSaveText(){
        saveDialog(titleBar: "save text")
    }
    
    func loadTextFile(){
        loadDialog(titleBar: "Load text")
    }
    
    func fileSaveData(){
        saveDialog(titleBar: "save file")
    }
    
    func fileLoadData(){
        loadDialog(titleBar: "load file")
    }
    
    func saveDialog(titleBar:String){
        let dialog = NSSavePanel();
        dialog.title = titleBar;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            let nameResult = dialog.nameFieldStringValue
            //print("name:\(nameResult)")
                if (result != nil) {
                   fileNameData = nameResult
                   filePath = result!.path
                   print("filepath:\(filePath!)")
                }
            } else {
                // User clicked on "Cancel"
                return
            }
     /*let chosenFile = dialog.url
        if chosenFile != nil {
          //  let image = NSImage(contentsOf: chosenFile!)
           // self.scaleImage(image: image!)
        }*/
    }//
    
    func loadDialog(titleBar:String){
        let dialog = NSOpenPanel();
            dialog.title                   = titleBar;
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = false;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
                if (result != nil) {
                   filePath = result!.path
                }
            } else {
                // User clicked on "Cancel"
                return
            }
    }
    
    func fileUrlToString()->String {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        print("documentURL:\(documentsUrl)")
        let retStr = try? String(contentsOf: documentsUrl)
        return retStr!
    }
    
    public func saveImageInDirectory(fileName: String, imageData: NSImage, fileEtx: String) {
       // let fileURL = documentsUrl.appendingPathComponent(newfileName)
        let fileURL = URL(fileURLWithPath: (filePath?.appending(fileEtx))!)

        print("fileurl:\(fileURL)")

           // let imageData = image!.pngData()! as NSData
            if let imageData = imageData.pngData {
                try? imageData.write(to: fileURL, options: .atomic)
            }
           // return nil
        }
}

extension NSImage {
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation)
        else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    
    func pngWrite(to url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do {
            try pngData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
