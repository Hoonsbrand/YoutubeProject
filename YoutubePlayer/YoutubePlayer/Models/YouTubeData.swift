//
//  YouTubeData.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/22.
//

import Foundation

// MARK: - PopularVideos
struct PopularVideos: Codable {
    let items : [Item]
}

// MARK: - Item
struct Item: Codable, Identifiable {
    let snippet: Snippet
    let id: String
    let statistics: Statistics
}

// MARK: - Snippet
struct Snippet: Codable {
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title
    }
}

// MARK: - Statistics
struct Statistics: Codable {
    let viewCount, likeCount, favoriteCount, commentCount: String
}
