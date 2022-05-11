//
//  ChatViewController.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/08.
//

import UIKit

final class ChatViewController: UIViewController {
  
  private enum ChatConstants {
    
    static let cellIdentifier = "ReusableCell"
    
    static let cellNibName = "MessageCell"
    
    static let anotherUserBackgroundColor = UIColor(named: "Other Chat BackgroundColor")
    
    static let currentUserBackgroundColor = UIColor(named: "Background Color")
    
  }
  
  @IBOutlet weak var phoneCallButton: UIButton!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var typingView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  var messages: [Message] = [
    Message(sender: "ME", body: "Hello, World?"),
    Message(sender: "YOU", body: "Have a Nice day :)"),
    Message(
      sender: "ME",
      body: "고마워!! 여러가지로 고맙네 ㅎㅎ 잠시 긴 문자에 대한 테스트를 진행할 예정이야. 잘 보일지는 모르겠넹? 헤헤"
    )
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
