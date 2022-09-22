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
    private var selectedVideo: String?
    
    private let videoManager = VideoManager()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        configureUI()
        
        videoManager.performRequest { 
            self.videoCollectionView.reloadData()
        }
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        let videoCustomCellNib = UINib(nibName: String(describing: VideoCell.self), bundle: nil)
        videoCollectionView.register(videoCustomCellNib, forCellWithReuseIdentifier: String(describing: VideoCell.self))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "youtubePremium")
        imageView.image = image
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: imageView)
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
        return videoManager.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        let videos = videoManager.videos
        let urlString = "https://img.youtube.com/vi/\(videos[indexPath.row].id)/0.jpg"
        let fileURL = URL(string: urlString)
        cell.videoImage.kf.setImage(with: fileURL)
        cell.getTitle(title: videos[indexPath.row].snippet.title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedVideo = videoManager.videos[indexPath.row].id
        performSegue(withIdentifier: "goToPlayVideo", sender: nil)
    }
    
}

// MARK: - 컬렉션 뷰 FlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 0
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 1
        let height: CGFloat = width * 8/7
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - 스크롤 하면 네비게이션 바 숨김
extension ViewController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
//                self.navigationController?.setToolbarHidden(true, animated: true)
            }, completion: nil)

        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
//                self.navigationController?.setToolbarHidden(false, animated: true)
            }, completion: nil)
          }
       }
}


