//
//  FriendsViewController.swift
//  VKClient
//
//  Created by albert on 31.03.2018.
//  Copyright © 2018 albert. All rights reserved.
//

import Foundation
import UIKit



struct Response: Decodable {
    var count: Int
    var item: Friends
    
}

struct Friends: Decodable {
    var name: String
    var imageUrl: URL?
    
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
    
//    func getFriends() {
//        
//        let theURL = "https://api.vk.com/method/friends.get?access_token=\(theToken!)&fields=photo_50&lang=ru&count=100&version=5.69&"
//    
//        guard let url = URL(string: theURL) else {return}
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else {return}
//            guard error == nil else {return}
//            do{
//            try JSONDecoder().decode(Response.self, from: data)
//            } catch let error {
//                print ("error")
//            }
//        
//        }
//        
//    }
    
}
