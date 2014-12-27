//
//  Member.swift
//  post
//
//  Created by Derek Li on 14/12/27.
//  Copyright (c) 2014年 Derek Li. All rights reserved.
//

import Foundation

class Member{
    var id                  :Int = 0
    
    var userimageurl            :String?
    var username     :String?
    
    var links               :NSDictionary!
    
    
    
    init(){
        
    }
    init(dic:NSDictionary){
        
        self.reloadAttr(dic)
        
        
    }
    
    func reloadAttr(dic:NSDictionary){
        self.id = dic.objectForKey("id") as Int
        
        self.username = dic.objectForKey("username") as? String
        self.userimageurl = dic.objectForKey("userimageurl") as? String
        self.links = dic.objectForKey("_links") as NSDictionary
    }
}