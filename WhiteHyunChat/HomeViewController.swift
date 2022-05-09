//
//  ViewController.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/07.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var decorationView: UIView!
  @IBOutlet weak var storyCollectionView: UICollectionView!
  @IBOutlet weak var chatTableView: UITableView!
  
  let personCount = 7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    storyCollectionView.delegate = self
    storyCollectionView.dataSource = self
    
    chatTableView.dataSource = self

    
    // 뷰의 위쪽 모서리를 둥글게 함
    decorationView.layer.cornerRadius = 35
    decorationView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
  }
  
}

//MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 15
  }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return personCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCollectionViewCell else {
      return UICollectionViewCell()
    }
    cell.storyButton.layer.cornerRadius = 0.5 * cell.storyButton.bounds.size.width
    cell.storyButton.clipsToBounds = true
    
    // plus 기호
    if indexPath.row == 0 {
      cell.storyButton.setImage(UIImage(systemName: "plus"), for: .normal)
      cell.storyButton.tintColor = UIColor(named: "Point Color")
      cell.storyButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    } else {
      // 스토리 버튼
      cell.storyButton.setImage(UIImage(named: "Person\(indexPath.row)"), for: .normal)
    }
    cell.storyButton.imageView?.contentMode = .scaleAspectFill
    return cell
  }
}


extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as? ChatListCell else {
      return UITableViewCell()
    }
    cell.updateUI(index: indexPath.row)
    return cell
  }
}
