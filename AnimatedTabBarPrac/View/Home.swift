//
//  Home.swift
//  AnimatedTabBarPrac
//
//  Created by 이보한 on 2024/2/1.
//

import SwiftUI

struct Home: View {
    // View Properties
    @State private var activeTab: Tab = .photos
    // All Tab's
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    // Bounce Property
    @State private var bouncesDown: Bool = true
    var body: some View {
        VStack(spacing: 0)
        {
            TabView(selection: $activeTab) {
                // 탭 뷰들
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.photos.title)
                }
                .setUpTab(.photos)
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.chat.title)
                }
                .setUpTab(.chat)

                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.apps.title)
                }
                .setUpTab(.apps)

                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.notifications.title)
                }
                .setUpTab(.notifications)

                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.profile.title)
                }
                .setUpTab(.profile)

            }
            
            // 테스트
            Picker("", selection: $bouncesDown) {
                Text("Bounces Down")
                    .tag(true)
                
                Text("Bounces Up")
                    .tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
           CustomTabBar()
            
            
        }
    }
    
    // Custom Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                        .symbolEffect(bouncesDown ? .bounce.down.byLayer : .bounce.up.byLayer, value: animatedTab.isAnimating)
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                    
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                
                // 원한다면 버튼을 사용할 수도 있다
                .onTapGesture {
                    withAnimation(.smooth, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                    
                }
            }
        }
        // iOS17부터, bar, fill, background같은 기본 백그라운드를 사용할 수 있다.
        .background(.bar)
    }
}

#Preview {
    Home()
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}
