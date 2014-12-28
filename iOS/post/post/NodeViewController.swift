//
//  NodeViewController.swift
//  post
//
//  Created by Derek Li on 14/12/24.
//  Copyright (c) 2014年 Derek Li. All rights reserved.
//

import Foundation
import UIKit

class NodeViewController:ViewController,UITableViewDelegate,UITableViewDataSource {
    var refreshControl = UIRefreshControl()
    //var flag = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "节点"
        
        var frame = self.view.frame
        self.tableView = UITableView(frame: frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyTestCell")
        self.view.addSubview(self.tableView!)
        
        
        
        //添加刷新
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "松开后自动刷新")
        
        
        self.tableView!.addSubview(refreshControl)
        
        self.getData()
        
    }
    func getData(){
        
        var dl=HttpClient()
        var url = "\(Constant().URL_NODE_LIST)"
        
        dl.downloadFromGetUrl(url, completionHandler: {(data: NSData?, error: NSError?) -> Void in
            if (error != nil){
                println("error=\(error!.localizedDescription)")
            }else{
                var dict=NSJSONSerialization.JSONObjectWithData(data!, options:.MutableContainers, error:nil) as? NSDictionary
                dict=NSJSONSerialization.JSONObjectWithData(data!, options:.MutableContainers, error:nil) as? NSDictionary
                
                
                var commentArrayDic = dict?.objectForKey("_embedded") as NSDictionary
                self.dataArray = commentArrayDic.objectForKey("items") as NSArray
                
                self.tableView?.reloadData()
                
            }
        })
    }
    
    // 刷新数据
    func refreshData() {
        self.getData()
        self.tableView!.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "newsCell")
        
        //let obj: New = dataArray[indexPath.row] as New
        let obj:NSDictionary = dataArray[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = obj.objectForKey("name") as? String
        //        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "yyyy年 MM月 dd日"
        //
        //        let str = dateFormatter.stringFromDate(obj.title)
        cell.detailTextLabel?.text = obj.objectForKey("description") as? String
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //        下面是取消点击后的选中
        //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let obj:NSDictionary = dataArray[indexPath.row] as NSDictionary
        
        
        
        var postVC = PostViewController()
        postVC.resource = Constant.getLink(obj)
        postVC.navbarTitle = obj.objectForKey("name") as? String
        self.navigationController?.pushViewController(postVC , animated: true)
        
    }
    
    
}