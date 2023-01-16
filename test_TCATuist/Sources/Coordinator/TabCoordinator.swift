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
    var router: NSTabController?
    lazy var tab1Coordinator: some Coordinatable = createTab(rootView: AView(), tabBarItem: tabBarItem1)
    lazy var tab2Coordinator: some Coordinatable = createTab(rootView: BView(), tabBarItem: tabBarItem2)
    lazy var tab3Coordinator: some Coordinatable = createTab(rootView: MainView(), tabBarItem: tabBarItem3)
    
    init() {
        print("init tab coordinator")
        router = NSTabController(coordinators: [tab1Coordinator, tab2Coordinator, tab3Coordinator])
    }
    
    deinit {
        print("deinit tab coordinator")
    }
    
    var rootView: some View {
        NSTabView(router: router)
            .environmentObject(self)
            .environmentObject(tab1Coordinator)
            .environmentObject(tab2Coordinator)
            .environmentObject(tab3Coordinator)
    }
    
    private func createTab(rootView: any View, tabBarItem: UITabBarItem) -> some Coordinatable {
        return MainCoordinator(baseView: rootView, tabBarItem: tabBarItem)
    }
    
    func moveThirdTab() {
        router?.setSelectedIndex(2)
    }
    
    func selectedTab(index: Int) {
        router?.setSelectedIndex(index)
    }
    
    func secondTabNavigationTo(view: any View) {
        router?.moveView(tabIndex: 1, view: view)
    }
}
