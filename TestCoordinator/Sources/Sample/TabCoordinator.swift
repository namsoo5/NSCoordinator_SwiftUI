//
//  TabCoordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

final class TabCoordinator: TabCoordinatable {
    let tabBarItem1 = UITabBarItem(
        title: "A뷰",
        image: .add,
        selectedImage: nil
    )
    let tabBarItem2 = UITabBarItem(
        title: "B뷰",
        image: .checkmark,
        selectedImage: UIImage(systemName: "heart")
    )
    let tabBarItem3 = UITabBarItem(
        title: "C뷰",
        image: UIImage(systemName: "heart"),
        selectedImage: nil
    )
    /// 코디네이터 넣어주는 순서대로 탭뷰 생성
    var controller: NSTabController?
    
    init() {
        print("init tab coordinator")
        controller = NSTabController(coordinators: [])
    }
    
    deinit {
        print("deinit tab coordinator")
    }

    var defaultView: some View {
        NSTabView(controller: controller)
            .environmentObject(self)
    }
    
    private func createTab(rootView: some View, tabBarItem: UITabBarItem) -> some Coordinatable {
        return MainCoordinator(baseView: rootView, tabBarItem: tabBarItem)
    }
    
    func moveThirdTab() {
        controller?.setSelectedIndex(2)
    }
    
    func selectedTab(index: Int) {
        controller?.setSelectedIndex(index)
    }
    
    func secondTabNavigationTo(view: some View) {
        controller?.moveView(tabIndex: 1, view: view)
    }
}
