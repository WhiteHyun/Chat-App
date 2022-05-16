//
//  Color.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/16.
//

import Foundation


struct Color {
  
  static let anotherUserBackgroundColor = UIColor(named: "Other Chat BackgroundColor")
  
  static let currentUserBackgroundColor = UIColor(named: "Background Color")
  
  static let currentUserPointColor = UIColor(named: "Point Color")?.withAlphaComponent(0.5)
  
  static let anotherUserPointColor = UIColor.black.withAlphaComponent(0.5)
  
}
