//
//  Comment.swift
//  post
//
//  Created by Derek Li on 14/12/26.
//  Copyright (c) 2014年 Derek Li. All rights reserved.
//

import Foundation

class Comment{
    var id                  :Int = 0
    var postTitle               :String?
    var content             :String?
    var modified            :String?
    
    var memberName          :String?
    var memberImageUrl      :String?
    
    var links               :NSDictionary!
    
    
    
    init(){
        
    }
    init(dic:NSDictionary){
        
        
        self.id = dic.objectForKey("id") as Int
        self.postTitle = dic.objectForKey("postTitle") as? String
        self.content = dic.objectForKey("content") as? String
        self.modified = dic.objectForKey("modified") as? String
        
        self.memberImageUrl = dic.objectForKey("memberimageurl") as? String
        self.memberName =  dic.objectForKey("memberName") as? String
        
        self.links = dic.objectForKey("_links") as NSDictionary
        
    }
    
}