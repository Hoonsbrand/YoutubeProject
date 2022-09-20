//
//  VideoPlayController.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/20.
//

import UIKit
import WebKit

class VideoPlayController: UIViewController {

    @IBOutlet weak var videoWebView: WKWebView!
    
    var videoKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.playVideo()
        }
        
    }

    func playVideo() {
        guard let videoKey = self.videoKey else { return }
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") else { return }
        videoWebView.load(URLRequest(url: url))
    }
    
    func getVideoKey(videoKey: String) {
        self.videoKey = videoKey
    }
    
}
