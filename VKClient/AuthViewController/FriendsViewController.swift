//
//  FriendsViewController.swift
//  VKClient
//
//  Created by albert on 31.03.2018.
//  Copyright © 2018 albert. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


struct Response:Decodable {
    var count:Int
    var item:Friends
    
}
struct Friends:Decodable {
    var name:String
    var imageUrl:URL?
    
}


class FriendsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else {
            fatalError()
        }
        return cell
    }
    
    
        
    }
    

