//
//  Tab.swift
//  AnimatedTabBarPrac
//
//  Created by 이보한 on 2024/2/1.
//

import SwiftUI

// Tab's
enum Tab: String, CaseIterable {
    case photos = "photo.stack"
    case chat = "bubble.left.and.text.bubble.right"
    case apps = "square.3.layers.3d"
    case notifications = "bell.and.waves.left.and.right"
    case profile = "person.2.crop.square.stack.fill"
    
    var title: String {
        switch self {
        case .photos:
            return "Photos"
        case .chat:
            return "Chat"
        case .apps:
            return "Apps"
        case .notifications:
            return "Notifications"
        case .profile:
            return "Profile"
        }
    }
}

// Animated SF Tab Model
struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}
