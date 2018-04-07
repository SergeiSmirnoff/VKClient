//
//  UserSettings.swift
//  VKClient
//
//  Created by albert on 07.04.2018.
//  Copyright © 2018 albert. All rights reserved.
//

import Foundation

class UserSettings {
    static var token: String {
        get {
         return UserDefaults.standard.string(forKey: "token") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "token")
        }
    }
}
