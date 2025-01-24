//
//  VideoModel.swift
//  PseudoTikTok
//
//  Файл содержит описание структуры данных для видео
//
//
//  Created by Никита Кулагин on 24.01.2025.
//

import Foundation

struct Video {
    let videoID: String
    let userID: String
    let videoURL: String
    var description: String
    var likesCount: Int
    let timestamp: Date

    init(videoID: String, userID: String, videoURL: String, description: String, likesCount: Int = 0, timestamp: Date = Date()) {
        self.videoID = videoID
        self.userID = userID
        self.videoURL = videoURL
        self.description = description
        self.likesCount = likesCount
        self.timestamp = timestamp
    }
}
