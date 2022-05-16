//
//  MessageManager.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/16.
//

import Foundation

import Firebase


protocol MessageDelegate: AnyObject {
  func didLoadMessages()
}


final class MessageManager {
  
  // MARK: - Property Part
  
  // 챗 버블 배열
  var messages: [Message] = []
  
  // firebase database
  let db = Firestore.firestore()
  
  // 채팅 변경 리스너
  var listener: ListenerRegistration?
  
  // delegate
  weak var delegate: MessageDelegate?
  
  
  
  // MARK: - Initialize Part
  
  deinit {
    // 리스너가 계속 호출되지 않도록 리스너를 제거한다.
    listener?.remove()
  }
  
  //MARK: - Function Part
  
  func loadMessages() {
    // 시간별로 정렬하여 값을 가져온다.
    // 채팅 데이터베이스가 변경될 때마다 addSnapshotListener에서 정의한 클로저가 실행된다.
    self.listener = db.collection(ChatConstants.DB.collectionName)
      .order(by: ChatConstants.DB.date)
      .addSnapshotListener { [unowned self] querySnapshot, error in
        
        guard let snapshotDocuments = querySnapshot?.documents else {
          print("There was an issue retrieving data from Firstore. \(String(describing: error))")
          return
        }
        
        self.messages = []
        // document -> chat bubble instance property
        for document in snapshotDocuments {
          let data = document.data()
          if let senderEmail = data[ChatConstants.DB.sender] as? String,
             let messageBody = data[ChatConstants.DB.body] as? String,
             let messageDate = data[ChatConstants.DB.date] as? Double {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            let date = dateFormatter.string(from: Date(timeIntervalSince1970: messageDate))
            self.messages.append(Message(sender: senderEmail, body: messageBody, date: date))
          }
        }
        
        // 객체를 갖고있는 `VC`에게 끝났다고 알려줌
        self.delegate?.didLoadMessages()
      }
  }
  
  
  func sendMessages(user messageSender: String, body messageBody: String) {
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
  }
}
