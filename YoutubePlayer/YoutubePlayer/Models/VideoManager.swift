//
//  VideoManager.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/22.
//

import Foundation

class VideoManager {
    
    var videos = [Item]()
    
    func performRequest(completion: @escaping () -> ()) {
        
        let pageToken = PageToken.shared
        
        var url: URL?
        
        // 다음 페이지 토큰이 없을 때 (맨 처음 페이지 로드할 때)
        if pageToken.nextPageToken == nil {
            url = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=statistics,snippet&chart=mostPopular&maxResults=25&regionCode=KR&key=\(Bundle.main.YOUTUBE_API_KEY)")!
        } else {
            url = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=statistics,snippet&chart=mostPopular&maxResults=25&regionCode=KR&pageToken=\(pageToken.nextPageToken!)&key=\(Bundle.main.YOUTUBE_API_KEY)")!
        }
        
        URLSession.shared.dataTask(with: url!){ [weak self] (data, response, error) in
            guard let self = self else { return }
            
            do {
                let videoList = try JSONDecoder().decode(PopularVideos.self, from: data!)
                pageToken.getNextPageToken(videoList.nextPageToken)
                self.videos = videoList.items
            }
            catch {
                print("There was an error finding data \( error)")
            }
            
            DispatchQueue.main.async {
                completion()
            }
            
        }.resume()
    }
}

extension Bundle {
    
    // 생성한 .plist 파일 경로 불러오기
    var YOUTUBE_API_KEY: String {
        guard let file = self.path(forResource: "YouTubeInfo", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["YOUTUBE_API_KEY"] as? String else {
            fatalError("YOUTUBE_API_KEY error")
        }
        return key
    }
}
