//
//  ChatViewController.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/08.
//

import UIKit

import Firebase

final class ChatViewController: UIViewController {
  
  private enum ChatConstants {
    
    static let cellIdentifier = "ReusableCell"
    
    static let cellNibName = "MessageCell"
    
    static let anotherUserBackgroundColor = UIColor(named: "Other Chat BackgroundColor")
    
    static let currentUserBackgroundColor = UIColor(named: "Background Color")
    
    enum DB {
      
      static let collectionName = "messages"
      
      static let senderField = "sender"
      
      static let body = "body"
      
      static let date = "date"
      
    }
    
  }
  var otherPersonName: String?
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var phoneCallButton: UIButton!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var typingView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  var messages: [Message] = []
  
  let db = Firestore.firestore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Update name
    nameLabel.text = otherPersonName
    
    // delegate set
    tableView.dataSource = self
    
    
    // register custom cell
    tableView.register(
      UINib(nibName: ChatConstants.cellNibName, bundle: nil),
      forCellReuseIdentifier: ChatConstants.cellIdentifier
    )
    // update UI
    updateUI()
  }
  
  
  /// Cell의 내부 View UI를 변경합니다. View Controller가 `load`된 뒤 실행하는 메소드입니다.
  private func updateUI() {
    phoneCallButton.layer.cornerRadius = 0.5 * phoneCallButton.bounds.size.height
    sendButton.layer.cornerRadius = 0.5 * sendButton.bounds.size.height
    typingView.layer.cornerRadius = 0.5 * typingView.bounds.size.height
  }
}

//MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
  
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: ChatConstants.cellIdentifier,
      for: indexPath
    ) as? MessageCell else {
      return UITableViewCell()
    }
    
    // 공통 변경사항
    cell.messageLabel.text = messages[indexPath.row].body
    cell.messageBubble.layer.cornerRadius = 10
    
    if messages[indexPath.row].sender == "ME" {
      cell.leftView.isHidden = false
      cell.rightView.isHidden = true
      cell.messageBubble.backgroundColor = ChatConstants.anotherUserBackgroundColor
      cell.messageBubble.layer.maskedCorners = [
        .layerMaxXMinYCorner,
        .layerMinXMinYCorner,
        .layerMaxXMaxYCorner
      ]
    } else {
      cell.leftView.isHidden = true
      cell.rightView.isHidden = false
      cell.messageBubble.backgroundColor = ChatConstants.currentUserBackgroundColor
      cell.messageBubble.layer.maskedCorners = [
        .layerMaxXMinYCorner,
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner
      ]
    }
    
    return cell
  }
  
}
