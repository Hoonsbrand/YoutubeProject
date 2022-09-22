//
//  VideoPlayController.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/20.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoPlayController: UIViewController {

    @IBOutlet weak var playerView: WKYTPlayerView!
    
    private var videoKey: String?
    private let playVarsDic = ["playsinline": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.delegate = self
        loadVideo()
        
    }
    
    // MARK: - 비디오 로드
    func loadVideo() {
        guard let videoKey = self.videoKey else { return }
        playerView.load(withVideoId: videoKey, playerVars: playVarsDic)
    }
    
    // MARK: - 비디오 key 받아오기
    func getVideoKey(videoKey: String) {
        self.videoKey = videoKey
    }
}

extension VideoPlayController: WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
    }
}
