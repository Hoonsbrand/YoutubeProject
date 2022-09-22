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
        let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=statistics,snippet&chart=mostPopular&maxResults=25&key=\(YouTubeKey.youTubeKey)")!
        
        URLSession.shared.dataTask(with: url){ [weak self] (data, response, error) in
            guard let self = self else { return }
            
            do {
                let videoList = try JSONDecoder().decode(PopularVideos.self, from: data!)
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
