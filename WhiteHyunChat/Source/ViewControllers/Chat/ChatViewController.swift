//
//  ChatViewController.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/08.
//

import UIKit

import Firebase

enum ChatConstants {
  
  static let anotherUserBackgroundColor = UIColor(named: "Other Chat BackgroundColor")
  
  static let currentUserBackgroundColor = UIColor(named: "Background Color")
  
  static let currentUserPointColor = UIColor(named: "Point Color")?.withAlphaComponent(0.5)
  
  static let anotherUserPointColor = UIColor.black.withAlphaComponent(0.5)
  
  enum DB {
    
    static let collectionName = "messages"
    
    static let sender = "sender"
    
    static let body = "body"
    
    static let date = "date"
    
  }
  
}

final class ChatViewController: UIViewController {
  
  //MARK: - IBOutlet Part
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var phoneCallButton: UIButton!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var typingView: UIView!
  @IBOutlet weak var typingTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  
  //MARK: - Property Part
  
  var otherPersonName: String?
  var messageManager = MessageManager()
  
  
  //MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Update name
    nameLabel.text = otherPersonName
    
    // delegate set
    tableView.dataSource = self
    messageManager.delegate = self
    
    
    // register custom cell
    tableView.register(
      UINib(nibName: MessageCell.cellNibName, bundle: nil),
      forCellReuseIdentifier: MessageCell.cellIdentifier
    )
    
    updateUI()
    loadMessages()
  }
  
  //MARK: - IBAction Part
  
  @IBAction func sendButtonDidTaps(_ sender: UIButton) {
    
    guard let messageBody = typingTextField.text,
          !messageBody.isEmpty,
          let messageSender = Auth.auth().currentUser?.email else {
      return
    }
    
    messageManager.sendMessages(user: messageSender, body: messageBody)
    
    // 메시지 보낸 후 textField 비움
    typingTextField.text = ""
  }
  
  //MARK: - Function Part
  
  
  /// Cell의 내부 View UI를 변경합니다. View Controller가 `load`된 뒤 실행하는 메소드입니다.
  private func updateUI() {
    phoneCallButton.layer.cornerRadius = 0.5 * phoneCallButton.bounds.size.height
    sendButton.layer.cornerRadius = 0.5 * sendButton.bounds.size.height
    typingView.layer.cornerRadius = 0.5 * typingView.bounds.size.height
  }
  
  
  /// 이전에 대화했던 메시지를 불러옵니다.
  private func loadMessages() {
    messageManager.loadMessages()
  }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageManager.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: MessageCell.cellIdentifier,
      for: indexPath
    ) as? MessageCell else {
      return UITableViewCell()
    }
    
    // 공통 변경사항
    cell.messageLabel.text = messageManager.messages[indexPath.row].body
    cell.messageBubble.layer.cornerRadius = 10
    cell.timeLabel.text = messageManager.messages[indexPath.row].date
    
    // my messages
    if messageManager.messages[indexPath.row].sender == Auth.auth().currentUser!.email {
      cell.configureMyMessageCell()
    } else {
      cell.configureOtherMessageCell()
    }
    
    return cell
  }
}

//MARK: - MessageDelegate


extension ChatViewController: MessageDelegate {
  func didLoadMessages() {
    DispatchQueue.main.async {
      let indexPath = IndexPath(row: self.messageManager.messages.endIndex - 1, section: 0)
      self.tableView.reloadData()
      self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
  }
}
