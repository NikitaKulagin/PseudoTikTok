//
//  UserModel.swift
//  PseudoTikTok
//
//  Файл содержит описание структуры данных для пользователя
//
//  Created by Никита Кулагин on 24.01.2025.
//

import Foundation

struct User {
    let userID: String
    var username: String
    let email: String
    var profilePictureURL: String?

    init(userID: String, username: String, email: String, profilePictureURL: String? = nil) {
        self.userID = userID
        self.username = username
        self.email = email
        self.profilePictureURL = profilePictureURL
    }
}
