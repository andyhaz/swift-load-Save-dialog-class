//
//  myTableView.swift
//  rabbit
//
//  Created by andyhaz on 12/28/22.
//

import Foundation
import Cocoa

class myTableView: NSTableCellView {
    //set up delgate
    weak var delegate: tableDelegate?
    
    var checkTitle:String = ""
    var checkState:Bool = true
    var cellId:Int = 0
    static let identifier = "myTableView"
    
    static func nib() -> NSNib {
        return NSNib(nibNamed: "myTableView",
                     bundle: nil)!
    }
    
    @IBOutlet weak var checkOutlet: NSButton!
    
    @IBAction func checkButton(_ sender: Any) {
        checkState = (checkOutlet.state.rawValue != 0)
      //  print("check:\(checkState)")        
        self.delegate?.tableEvent(cellId: cellId, CheckData:checkState)
    }
    
    func configer(title:String,id:Int){
         checkTitle = title
         checkOutlet?.title = title
       //  print(title)
         cellId = id
       // print(id)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
  /*  override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }*/
}
