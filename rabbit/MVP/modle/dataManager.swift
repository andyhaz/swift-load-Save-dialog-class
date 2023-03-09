//
//  dataProfile.swift
//  rabbit
//
//  Created by andyhaz on 3/7/23.
//

import Foundation

struct screenSizeData {
    var seleCheckBox:Bool
    var height:Int
    var width:Int
    var tableDisplay:String
}//

class dataManager{
    
    var tempData: [screenSizeData] = []
    
    func defaultData() {
        let ss1 = screenSizeData(seleCheckBox: true, height: 100, width: 100, tableDisplay: "100X100")
        let ss2 = screenSizeData(seleCheckBox: true, height: 200, width: 200, tableDisplay: "200X200")
        let ss3 = screenSizeData(seleCheckBox: true, height: 300, width: 300, tableDisplay: "300X300")
        let ss4 = screenSizeData(seleCheckBox: true, height: 400, width: 400, tableDisplay: "400X400")
        
        tempData.append(ss1)
        tempData.append(ss2)
        tempData.append(ss3)
        tempData.append(ss4)
    }
}
