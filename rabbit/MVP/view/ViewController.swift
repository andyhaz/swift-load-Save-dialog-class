//
//  ViewController.swift
//  rabbit
//
//  Created by andyhaz on 12/13/22.
//

import Cocoa

protocol tableDelegate:AnyObject{
    func tableEvent(cellId:Int,CheckData:Bool)
}

struct screenSizeData {
    var seleCheckBox:Bool
    var height:Int
    var width:Int
    var tableDisplay:String
}

class ViewController:NSViewController,NSTableViewDataSource,NSTableViewDelegate,tableDelegate {
    
    var filename_field:String = ""

    @IBOutlet weak var myView: MyView!
  
    @IBOutlet var tableView: NSTableView!
    

    @IBAction func openImageAction(_ sender: Any) {
        openDialog()
    }
    
    @IBAction func saveImageAction(_ sender: Any) {
        saveDialog()
    }

    //create table data
    var tempData: [screenSizeData] = []
    var rowsWhichAreChecked = [NSIndexPath]()
    var selectRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let ss1 = screenSizeData(seleCheckBox: true, height: 100, width: 100, tableDisplay: "100X100")
        let ss2 = screenSizeData(seleCheckBox: true, height: 200, width: 200, tableDisplay: "200X200")
        let ss3 = screenSizeData(seleCheckBox: true, height: 300, width: 300, tableDisplay: "300X300")
        let ss4 = screenSizeData(seleCheckBox: true, height: 400, width: 400, tableDisplay: "400X400")
        
        tempData.append(ss1)
        tempData.append(ss2)
        tempData.append(ss3)
        tempData.append(ss4)
        
        view.wantsLayer = true
        // Set the initial background color.
        // By using the correct class name (MyView) above, you can now
        // call the custom function to change the background color.
        updateView()
       
        tableView.register(myTableView.nib(), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: myTableView.identifier) )
        
        tableView.dataSource = self
    }
 
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (tempData.count)
    }
      
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
          
        let cellData = tempData[row]
        guard let userCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "myTableView"), owner: self) as? myTableView else { return nil }
          
        userCell.configer(title:cellData.tableDisplay, id: row)
          
        userCell.delegate = self
          
        return userCell
      }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        selectRow = row
        print(tempData[selectRow])
        
       updateView()
        
        return true
    }
    //
   func updateView(){
        myView.clearView()
        myView.setFrameSize(NSSize(width:tempData[selectRow].height, height: tempData[selectRow].height))
        
        myView.loadImageView(fileName:filename_field, FileWidth: Float(tempData[selectRow].width), fileHeight: Float(tempData[selectRow].height))
        
        myView.changeBackgroundColor(color: .clear)
    }
    //
    func tableEvent(cellId:Int,CheckData:Bool){
        //  print("tableEvent:\(cellId)")
        tempData[cellId].seleCheckBox = CheckData
      //  print("tempdata:\(tempData[cellId])")
      }
    
    func openDialog(){
        let dialog = NSOpenPanel();
            dialog.title                   = "Choose a image file";
            dialog.showsResizeIndicator    = true;
            dialog.showsHiddenFiles        = false;
            dialog.canChooseDirectories    = true;
            dialog.canCreateDirectories    = true;
            dialog.allowsMultipleSelection = false;
         //   dialog.allowedFileTypes        = ["png"];
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
                if (result != nil) {
                    let path = result!.path
                    filename_field = path
                  //  print(filename_field)
                    //load image
                    updateView()
                }
            } else {
                // User clicked on "Cancel"
                return
            }
    }//clode
    
    func saveDialog () {
        let image = NSImage()
        let panel = NSSavePanel()
       // panel.allowsMultipleSelection = false
      //  panel.canChooseFiles = true
      //  panel.canChooseDirectories = true
        panel.runModal()
       // panel.allowedFileTypes = ["png", "jpeg", "jpg"]
        let chosenFile = panel.url
        if chosenFile != nil {
          //  let image = NSImage(contentsOf: chosenFile!)
            let image = myView.myImage
            saveImageInDocumentDirectory(image:image, fileName: "test.png")
           // self.scaleImage(image: image!)
        }
    }
    
    public func saveImageInDocumentDirectory(image: NSImage, fileName: String) {
            
            let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
            let fileURL = documentsUrl.appendingPathComponent(fileName)
           // let imageData = image!.pngData()! as NSData
            if let imageData = image.pngData {
                try? imageData.write(to: fileURL, options: .atomic)
              //  return fileURL
                print(fileURL)
            }
           // return nil
        }
    
    func scaleImage (image:NSImage){
     
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
