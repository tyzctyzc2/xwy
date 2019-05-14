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
            //allTargetUrl["程悦"] = "http://sbj.speiyou.com/classes/view/ff80808166f38a05016706d1f81d1a11"
            //allTargetUrl["姜付加"] = "http://sbj.speiyou.com/classes/view/ff8080816705ca02016706c500b6756d"
            
            nameList.append("崔梦迪一期上午")
            addressList.append("http://sbj.speiyou.com/classes/view/72ac93f820154370ab17c04d0c48b4ad")
            
            nameList.append("周王莹零期下午")
            addressList.append("http://sbj.speiyou.com/classes/view/a9613ed160854a77b776b69149bc2169")
            
            nameList.append("程硕零期下午")
            addressList.append("http://sbj.speiyou.com/classes/view/16cb9e8f86584c3f99670947e94599e3")
        }
    }
    
    /*public static func getUrl() -> [String:String]{
        return GrabUrlHolder.allTargetUrl;
    }*/
    
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
