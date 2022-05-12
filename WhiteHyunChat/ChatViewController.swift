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
    
    static let currentUserPointColor = UIColor(named: "Point Color")?.withAlphaComponent(0.5)
    
    static let anotherUserPointColor = UIColor.black.withAlphaComponent(0.5)
    
    enum DB {
      
      static let collectionName = "messages"
      
      static let sender = "sender"
      
      static let body = "body"
      
      static let date = "date"
      
    }
    
  }
  var otherPersonName: String?
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var phoneCallButton: UIButton!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var typingView: UIView!
  @IBOutlet weak var typingTextField: UITextField!
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
    loadMessages()
  }
  
  /// Cell의 내부 View UI를 변경합니다. View Controller가 `load`된 뒤 실행하는 메소드입니다.
  private func updateUI() {
    phoneCallButton.layer.cornerRadius = 0.5 * phoneCallButton.bounds.size.height
    sendButton.layer.cornerRadius = 0.5 * sendButton.bounds.size.height
    typingView.layer.cornerRadius = 0.5 * typingView.bounds.size.height
  }
  
  
  
  /// 이전에 대화했던 메시지를 불러옵니다.
  private func loadMessages() {
    db.collection(ChatConstants.DB.collectionName)
      .order(by: ChatConstants.DB.date)
      .addSnapshotListener { [unowned self] querySnapshot, error in
        self.messages = []
        guard let snapshotDocuments = querySnapshot?.documents else {
          print("There was an issue retrieving data from Firstore. \(String(describing: error))")
          return
        }
        
        for document in snapshotDocuments {
          let data = document.data()
          if let sender = data[ChatConstants.DB.sender] as? String,
             let messageBody = data[ChatConstants.DB.body] as? String {
            
            self.messages.append(Message(sender: sender, body: messageBody))
            
            DispatchQueue.main.async {
              let indexPath = IndexPath(row: self.messages.endIndex - 1, section: 0)
              self.tableView.reloadData()
              self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
          }
        }
      }
  }
  
  
  @IBAction func sendButtonDidTaps(_ sender: UIButton) {
    guard let messageBody = typingTextField.text,
          let messageSender = Auth.auth().currentUser?.email else {
      return
    }
    db.collection(ChatConstants.DB.collectionName).addDocument(
      data: [
        ChatConstants.DB.sender: messageSender,
        ChatConstants.DB.body: messageBody,
        ChatConstants.DB.date: Date().timeIntervalSince1970
      ]
    ) {
      if let error = $0 {
        print("There was an issue saving data to firestore, \(error.localizedDescription)")
      } else {
        print("Successfully saved data.")
      }
    }
    typingTextField.text = ""
  }
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
    
    // my messages
    if messages[indexPath.row].sender == Auth.auth().currentUser!.email {
      cell.leftView.isHidden = false
      cell.rightView.isHidden = true
      cell.messageBubble.backgroundColor = ChatConstants.currentUserBackgroundColor
      cell.messageBubble.layer.maskedCorners = [
        .layerMaxXMinYCorner,
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner
      ]
      cell.timeLabel.textColor = ChatConstants.currentUserPointColor
    } else {
      cell.leftView.isHidden = true
      cell.rightView.isHidden = false
      cell.messageBubble.backgroundColor = ChatConstants.anotherUserBackgroundColor
      cell.messageBubble.layer.maskedCorners = [
        .layerMaxXMinYCorner,
        .layerMinXMinYCorner,
        .layerMaxXMaxYCorner
      ]
      cell.timeLabel.textColor = ChatConstants.anotherUserPointColor
    }
    
    return cell
  }
  
}
