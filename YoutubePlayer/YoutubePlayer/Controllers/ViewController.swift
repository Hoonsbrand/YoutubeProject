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
    
    private let videoPlayController = VideoPlayController()
    private let videos = VideoData().videos
    private var selectedVideo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoCustomCellNib = UINib(nibName: String(describing: VideoCell.self), bundle: nil)
        videoCollectionView.register(videoCustomCellNib, forCellWithReuseIdentifier: String(describing: VideoCell.self))
        
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        
        setUpFlowLayout()
        
    }
    
    // MARK: - FlowLayout 설정
    private func setUpFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 0.9
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9 , height: halfWidth * 0.9)
        self.videoCollectionView.collectionViewLayout = flowLayout
    }
    
    // MARK: - prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! VideoPlayController
        
        guard let video = selectedVideo else { return }
        vc.getVideoKey(videoKey: video)
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
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


