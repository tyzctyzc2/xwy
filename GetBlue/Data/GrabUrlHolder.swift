//
//  GrabUrlHolder.swift
//  GetBlue
//
//  Created by tyzc on 2019/4/26.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import Foundation

class GrabUrlHolder
{
    //static var allTargetUrl:[String:String] = [:]
    static var nameList:[String] = []
    static var addressList:[String] = []
    
    public static func loadUrl() {
        if (nameList.count == 0) {
            nameList.append("崔梦迪秋季")
            addressList.append("http://sbj.speiyou.com/classes/view/a5e086f0474b4216b8e40201671f4582")
            
            nameList.append("崔梦迪秋季A")
            addressList.append("http://sbj.speiyou.com/classes/view/f908cfdc391b40538c97f7c17caa1ee8")
            
        }
    }
    
    public static func getUrlCount() -> Int {
        return nameList.count
    }
    
    public static func getIndexItem(index: Int) -> (name: String, url: String) {
        let name = self.nameList[index];
        let url = self.addressList[index];
        return (name, url);
    }
    
    public static func addNewUrl(name: String, url: String) {
        nameList.append(name)
        addressList.append(url)
    }
    
    private static func saveData() {
        let nameData = NSKeyedArchiver.archivedData(withRootObject: nameList)
        UserDefaults.standard.set(nameData, forKey: "names")
    }
    
    private static func loadData() {
        
    }
    
    public static func removeUrl(index: Int) {
        nameList.remove(at: index)
        addressList.remove(at: index)
    }
}
