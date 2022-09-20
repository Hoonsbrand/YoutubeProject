//
//  ViewController.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/20.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    let videoPlayController = VideoPlayController()
    
    var videos: [Video] = []
    var selectedVideo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoCustomCellNib = UINib(nibName: String(describing: VideoCell.self), bundle: nil)
        videoCollectionView.register(videoCustomCellNib, forCellWithReuseIdentifier: String(describing: VideoCell.self))
        
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        
        addVideo()
        setUpFlowLayout()
        
    }
    
    func addVideo() {
        var video1 = Video()
        video1.key = "nQvSWD34tSU"
        video1.title = "마츠다부장님의 리얼 일하는 모습 독점공개 - 김과장TV"
        videos.append(video1)
        
        var video2 = Video()
        video2.key = "4EhjlB-wrdw"
        video2.title = "현재 넷플릭스 1위!! 주연들 미친 연기력으로 압도적 몰입감을 선사하는 개꿀잼 신작 느와르 한국 드라마《수리남》 처음부터 끝까지 한 방에 몰아보기!!"
        videos.append(video2)
        
        var video3 = Video()
        video3.key = "p-1YfF6lwww"
        video3.title = "[반달의 삶 : 카푸어 12화] 똥은 똥끼리 논다"
        videos.append(video3)
    }
    
    private func setUpFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 0.9
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9 , height: halfWidth * 0.9)
        self.videoCollectionView.collectionViewLayout = flowLayout
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! VideoPlayController
        
        guard let video = selectedVideo else { return }
        vc.getVideoKey(videoKey: video)
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        let urlString = "https://img.youtube.com/vi/\(videos[indexPath.row].key)/0.jpg"
        let fileURL = URL(string: urlString)
        cell.videoImage.kf.setImage(with: fileURL)
        cell.getTitle(title: videos[indexPath.row].title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        selectedVideo = videos[indexPath.row].key
        performSegue(withIdentifier: "goToPlayVideo", sender: nil)
    }
    
}


