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
        let ss1 = screenSizeData(seleCheckBox: true, height: 16, width: 16, tableDisplay: "16X16")
        let ss2 = screenSizeData(seleCheckBox: true, height: 32, width: 32, tableDisplay: "32X32")
        let ss3 = screenSizeData(seleCheckBox: true, height: 64, width: 64, tableDisplay: "64X64")
        let ss4 = screenSizeData(seleCheckBox: true, height: 128, width: 128, tableDisplay: "128X128")
        let ss5 = screenSizeData(seleCheckBox: true, height: 256, width: 256, tableDisplay: "256X256")
        let ss6 = screenSizeData(seleCheckBox: true, height: 512, width: 512, tableDisplay: "512X512")
        let ss7 = screenSizeData(seleCheckBox: true, height: 1024, width: 1024, tableDisplay: "1024X1024")

        tempData.append(ss1)
        tempData.append(ss2)
        tempData.append(ss3)
        tempData.append(ss4)
        tempData.append(ss5)
        tempData.append(ss6)
        tempData.append(ss7)
    }
}
