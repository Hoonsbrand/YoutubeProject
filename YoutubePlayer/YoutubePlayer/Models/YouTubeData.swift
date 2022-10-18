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
    let nextPageToken: String
}

// MARK: - Item
struct Item: Codable, Identifiable {
    let id: String
    let snippet: Snippet
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
    let viewCount, favoriteCount, commentCount: String
    let likeCount: String?
}

// MARK: - nextPageToken
class PageToken {
    static let shared = PageToken()
    
    var nextPageToken: String? 
    
    func getNextPageToken(_ nextPageToken: String) {
        self.nextPageToken = nextPageToken
    }
}

