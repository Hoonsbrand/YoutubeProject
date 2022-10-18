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
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        configureUI()
        
        videoManager.performRequest { 
            self.videoCollectionView.reloadData()
        }
        
        initRefresh()
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


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoManager.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL.VIDEO_CELL, for: indexPath) as! VideoCell
        
        let videos = videoManager.videos
        let urlString = "https://img.youtube.com/vi/\(videos[indexPath.row].id)/0.jpg"
        let fileURL = URL(string: urlString)
        
        let viewCountString = videoManager.videos[indexPath.row].statistics.viewCount
        let viewCount = numberFormatter(number: Int(viewCountString) ?? 0)
        
        if let likeCountString = videoManager.videos[indexPath.row].statistics.likeCount {
            let likeCount = numberFormatter(number: Int(likeCountString) ?? 0)
            cell.statisticsLabel.text = "조회수: \(viewCount)회\n좋아요: \(likeCount)개"
        }
        
        cell.videoImage.kf.setImage(with: fileURL)
        cell.getTitle(title: videos[indexPath.row].snippet.title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedVideo = videoManager.videos[indexPath.row].id
        performSegue(withIdentifier: SEGUE.GO_TO_PLAY_VIDEO, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 1
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 1.5
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - 최상단에서 뷰를 밑으로 땡겼을 때 새로고침
extension ViewController {
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh:)), for: .valueChanged)
        
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .purple
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        
        videoCollectionView.refreshControl = refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
           print("새로고침 시작")
           
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            self.videoManager.performRequest {
                   self.videoCollectionView.reloadData()
               }
               
               refresh.endRefreshing()
           }
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

// MARK: - 숫자 세자리수 단위 콤마
extension ViewController {
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
