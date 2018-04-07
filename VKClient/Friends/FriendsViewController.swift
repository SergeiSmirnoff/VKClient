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
import CodableAlamofire

struct Friend: Codable {
    var firstName: String
    var lastName: String
    var imageUrl: String
    var status: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "photo_50"
        case status = "online"
    }
}


class FriendsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getFriendsInfo()
    }
    
    private func registerCell () {
        let nib = UINib(nibName: "FriendTableViewCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "FriendTableViewCell")
    }
    
    private func getFriendsInfo() {
        let theURL = "https://api.vk.com/method/friends.get?access_token=\(UserSettings.token)&fields=photo_50&lang=ru&count=100&version=5.69&"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(theURL).responseDecodableObject(queue: nil, keyPath: "response", decoder: decoder) { (result: DataResponse<[Friend]>) in
            guard let friends = result.value else {
                return
            }
            self.friends = friends
            self.tableView.reloadData()
        }
    }
    
    private func loadImage(by url: String, completion: @escaping ((UIImage) -> Void)) {
        Alamofire.request(url).responseData { response in
            guard let data = response.value, let image = UIImage(data: data) else {
                return
            }
            completion(image)
        }
    }
}

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as? FriendTableViewCell else {
            fatalError()
        }
        cell.nameLabel.text = friends[indexPath.row].firstName + friends[indexPath.row].lastName
        if friends[indexPath.row].status == 1 {
            cell.statusView.backgroundColor = .green
        } else {
            cell.statusView.backgroundColor = .red
        }
        
        DispatchQueue.main.async {
            self.loadImage(by: self.friends[indexPath.row].imageUrl) { image in
                cell.photoImageView?.image = image
            }
            
            self.loadImage(by: self.friends[indexPath.row].imageUrl, completion: { image in
                cell.photoImageView?.image = image
            })
        }
        return cell
    }
}


//http://fuckingswiftblocksyntax.com/
//SWIFTBOOK (2x)
// PULL TO REFRESH
// Navigation controller
// При нажатии на ячейку друга, открывать новый VC с отображением большой картинки и полей: имя, фамилия, город (сделать возврат назад)
// Запросы вынести в отдельный слой
