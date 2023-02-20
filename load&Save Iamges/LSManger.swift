//
//  LSManger.swift
//  load&Save Iamges
//
//  Created by andyhaz on 1/31/23.
//

import Cocoa

class LSManger{
    
    var filePath:String? = nil
    var fileImageData:NSImage? = nil
    var fileTextData:String? = nil
    var fileNameData:String? = nil
    var fileDataArray:Array? = []
    
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
    
    func fileSaveText(textData:String){
        saveDialog(titleBar: "save text")
        saveTextInDirectory(fileName: fileNameData!, textData: textData, fileEtx: ".txt")
    }
    
    func fileLoadText(){
        loadDialog(titleBar: "Load text")
       // let txt:String
        fileTextData = loadTextInDirectory(fileName:filePath!)
       // print("text:\(txt)")
    }
    
    func fileSaveData(){
        saveDialog(titleBar: "save file")
        saveData(fileName:fileNameData!, arrayData: fileDataArray!, fileEtx: "grs")
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
    
    public func saveTextInDirectory(fileName: String, textData: String, fileEtx: String) {
       // let fileURL = documentsUrl.appendingPathComponent(newfileName)
        let fileURL = URL(fileURLWithPath: (filePath?.appending(fileEtx))!)

        print("fileurl:\(fileURL)")

        do {
            try textData.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
    }
    
    public func loadTextInDirectory(fileName:String)->String{
        var textData:String = ""
        
        do{
            textData = try String(contentsOfFile:fileName, encoding: .utf8)
        } catch {
            
        }
        return textData
    }
    
    public func saveData(fileName: String, arrayData: Array<Any>, fileEtx: String){
        let fileURL = URL(fileURLWithPath: (filePath?.appending(fileEtx))!)
        do {
           // try fileDataArray.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
            // Save to file
            (arrayData as NSArray).write(to: fileURL, atomically: true)
        }
    }
    
    public func fileCreatDir(dirName:String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent(dirName)
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
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

