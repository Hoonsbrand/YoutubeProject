//
//  YouTubeData.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/22.
//

import Foundation

struct PopularVideos: Codable {
    let items : [Item]
}

struct Item: Codable, Identifiable {
    let snippet: Snippet
    let id: String
}

struct Snippet: Codable {
    let title: String

    enum CodingKeys: String, CodingKey {
        case title
    }
}
