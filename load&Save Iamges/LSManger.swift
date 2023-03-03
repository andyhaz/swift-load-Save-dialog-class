//
//  LSManger.swift
//  load&Save Iamges
//
//  Created by andyhaz on 1/31/23.
//

import Cocoa
import Foundation

class LSManger{
    public func fileDialog(titleBar:String)->String{
        let dialog = NSOpenPanel();
            dialog.title                  = titleBar;
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = false;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
                if (result != nil) {
                   return result!.path
                }
            } else {
                // User clicked on "Cancel"
                return ""
            }
        return " "
    }
    
    public func fileLoadTextInDirectory(path:String)->String{
        var textData:String = ""
        
        do{
            textData = try String(contentsOfFile:path, encoding: .utf8)
        } catch {
            
        }
        return textData
    }
    
    func fileLoadImage(filePath:String)->NSImage{
        //load image
        return NSImage(contentsOfFile: filePath)!
      //  print("load image:\(String(describing: fileImageData))")
    }
    
    public func fileLoadData(filePath:String, fileName: String, fileEtx: String)->Array<Any>{
        let fileURL = URL(fileURLWithPath:filePath)
        print(fileURL)
        var ary:Array<Any> = []
        
        do {
            let data = try Data(contentsOf: fileURL)
            if let fileData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Any] {
               // print("fileData\(fileData)")
                ary.append(contentsOf: fileData)
            }
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
       // print("ary\(ary)")
        return ary
    }
//save
    public func fileSaveTextInDirectory(filePath:String, fileName: String, textData: String, fileEtx: String) {
       // let fileURL = documentsUrl.appendingPathComponent(newfileName)
        let fileURL = URL(fileURLWithPath: (filePath.appending(fileEtx)))
        print("fileurl:\(fileURL)")
        do {
            try textData.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
    }
    //
    public func fileSaveImageInDirectory(filePath:String, imageData:NSImage, fileEtx:String) {
       // let fileURL = documentsUrl.appendingPathComponent(newfileName)
        let fileURL = URL(fileURLWithPath: (filePath.appending(fileEtx)))
       // print("fileurl:\(fileURL)")
            if let imageData = imageData.pngData {
                do {
                    try imageData.write(to:fileURL, options: .atomic)
                } catch {
                   print(error)
                }
            }
    }//
    
    public func fileSaveData(filePath:String, fileName: String, aryData:Array<Any>, fileEtx: String){
        let fileURL = URL(fileURLWithPath: (filePath.appending(fileEtx)))
        print(fileURL)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: aryData, requiringSecureCoding: false)
            try data.write(to: fileURL)
            print("aryData:\(aryData)")

        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    public func fileCreatDirectory(dirName:String){
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
    
    public func fileUrlToString()->String {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        print("documentURL:\(documentsUrl)")
        let retStr = try? String(contentsOf: documentsUrl)
        return retStr!
    }
    
    public func filePathUrl()->URL{
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        print("documentURL:\(documentsUrl)")
        return documentsUrl
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
//
    //var filePath:String? = nil
    //var fileImageData:NSImage? = nil
    //var fileTextData:String? = nil
    //var fileNameData:String? = nil
    //var fileDataArray:Array? = []
    
    
//delete the botom
    /*
    func fileSaveImage(imgData:NSImage){
      //  let image = NSImage()
        saveDialog(titleBar: "save image")
        fileImageData = imgData
        if filePath != nil {
            saveImageInDirectory(fileName: fileNameData!, imageData: imgData, fileEtx: "png")
          //  print("save image")
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
        saveData(fileName:filePath!, aryData: fileDataArray!, fileEtx: ".grs")
    }
    
    func fileLoadData(){
        loadDialog(titleBar: "load file")
        fileDataArray = loadData(fileName: filePath!, fileEtx: ".grs")
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
    
    func filePathUrl()->URL{
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
        print("documentURL:\(documentsUrl)")
        return documentsUrl
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
    
    public func saveData(fileName: String, aryData:Array<Any>, fileEtx: String){
        let fileURL = URL(fileURLWithPath: (filePath?.appending(fileEtx))!)
        print(fileURL)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: aryData, requiringSecureCoding: false)
            try data.write(to: fileURL)
            print("aryData:\(aryData)")

        } catch {
            print("ERROR: \(error.localizedDescription)")
        }

/*        do {
            try joinedstring.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }*/
    }
    
    public func loadData(fileName: String, fileEtx: String)->Array<Any>{
        let fileURL = URL(fileURLWithPath:filePath!)
        print(fileURL)
        var ary:Array<Any> = []
        
        do {
            let data = try Data(contentsOf: fileURL)
            if let fileData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Any] {
               // print("fileData\(fileData)")
                ary.append(contentsOf: fileData)
            }
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
       // print("ary\(ary)")
        return ary
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
     */
