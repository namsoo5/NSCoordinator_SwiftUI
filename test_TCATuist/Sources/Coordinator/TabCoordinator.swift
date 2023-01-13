//
//  TabCoordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

final class TabCoordinator: ObservableObject {
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
    lazy var router: NSTabController = NSTabController(coordinators: [tab1Coordinator, tab2Coordinator, tab3Coordinator])
    lazy var tab1Coordinator: some Coordinator = createTab(rootView: AView(), tabBarItem: tabBarItem1)
    lazy var tab2Coordinator: some Coordinator = createTab(rootView: BView(), tabBarItem: tabBarItem2)
    lazy var tab3Coordinator: some Coordinator = createTab(rootView: MainView(), tabBarItem: tabBarItem3)
    
    init() {
        print("init tab coordinator")
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
    
    private func createTab(rootView: any View, tabBarItem: UITabBarItem) -> some Coordinator {
        let router = NSNavigationController(baseView: rootView, tabBarItem: tabBarItem)
        return MainCoordinator(router: router)
    }
    
    func moveThirdTab() {
        router.setSelectedIndex(2)
    }
    
    func selectedTab(index: Int) {
        router.setSelectedIndex(index)
    }
    
    func secondTabNavigationTo(view: any View) {
        router.moveView(tabIndex: 1, view: view)
    }
}
