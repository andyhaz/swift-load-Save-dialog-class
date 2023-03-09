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

class ViewController:NSViewController,NSTableViewDataSource,NSTableViewDelegate,tableDelegate {
    
   // var imageData:NSImage? = nil
    var filename_field:String = ""
    var lsm = LSManger()
    //
    let dm = dataManager()
    //create table data
    var sizeData: [screenSizeData] = []
    var rowsWhichAreChecked = [NSIndexPath]()
    var selectRow = 0

    @IBOutlet weak var myView: MyView!
  
    @IBOutlet var tableView: NSTableView!
    
    @IBAction func openImageAction(_ sender: Any) {
       // let image = myView.myImage
        myView.myImage = lsm.fileLoadImage(filePath:lsm.fileOpenDialog(titleBar: "open image"))
      //  myView.myImage =  myView.crop(nsImage: myView.myImage, rect: NSMakeRect(0, 0, CGFloat(sizeData[0].width), CGFloat(sizeData[0].height)))
        myView.displayImage(imageWidth:Float(sizeData[0].width), imageHeight: Float(sizeData[0].height))
    }
    
    @IBAction func saveImageAction(_ sender: Any) {
        let ls = LSManger()
        let savePath = ls.fileSaveDialog(titleBar: "Save image")
        scaleImage(image:myView.myImage, imagePath: savePath)
        print("save")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        dm.defaultData()
        sizeData.append(contentsOf: dm.tempData)
        
        view.wantsLayer = true
        // Set the initial background color.
        // By using the correct class name (MyView) above, you can now
        // call the custom function to change the background color.
        updateView()
       
        tableView.register(myTableView.nib(), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: myTableView.identifier) )
        
        tableView.dataSource = self
    }
 
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (sizeData.count)
    }
      
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
          
        let cellData = sizeData[row]
        guard let userCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "myTableView"), owner: self) as? myTableView else { return nil }
          
        userCell.configer(title:cellData.tableDisplay, id: row)
          
        userCell.delegate = self
          
        return userCell
      }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        selectRow = row
        print(sizeData[selectRow])
      //  print(myView as Any)
        
       updateView()
        
        return true
    }

    func tableEvent(cellId:Int,CheckData:Bool){
        //  print("tableEvent:\(cellId)")
        sizeData[cellId].seleCheckBox = CheckData
      //  print("tempdata:\(tempData[cellId])")
      }
    //
   func updateView(){
        myView.clearView()
        myView.setFrameSize(NSSize(width:sizeData[selectRow].width, height: sizeData[selectRow].height))
        
       myView.displayImage(imageWidth: Float(sizeData[selectRow].width), imageHeight: Float(sizeData[selectRow].height))
       myView.changeBackgroundColor(color: .red)
    }
    
    func scaleImage (image:NSImage, imagePath:String){
        var tempName:String
       // var newImage:NSImage
       // let ls = LSManger()
        for row in sizeData {
          //print(row)
            if(row.seleCheckBox == true){
                myView.clearView()
                // resize image
                myView.setFrameSize(NSSize(width:row.width, height:row.height))
                myView.displayImage(imageWidth:Float(row.width), imageHeight:Float(row.height))
                //rename file name
                tempName = "\(imagePath)\(row.tableDisplay)".appending(".png")
                
                //save image
                print("newImage:\(myView.myImage.size)")
                myView.changeBackgroundColor(color: .red)
                myView.fileSaveToDiskImage(filePath: tempName)
              //  ls.fileSaveImageInDirectory(filePath:tempName, imageData:myView.myImage, fileEtx: ".png")
            }//end if
        }//end loop
    }
}//end class
