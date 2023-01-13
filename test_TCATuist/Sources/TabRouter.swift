//
//  TabRouter.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/12.
//  Copyright © 2023 ns. All rights reserved.
//

import Foundation
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
    lazy var router: NSTabRouter = NSTabRouter(coordinators: [tab1Coordinator, tab2Coordinator, tab3Coordinator])
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
        let router = NSRouter(baseView: rootView, tabBarItem: tabBarItem)
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

final class NSTabRouter: ObservableObject {
    @Published private(set) var tabBarController: UITabBarController?
    private var coordinators: [any Coordinator] = []
    
    init(coordinators: [any Coordinator]) {
        self.coordinators = coordinators
        setupTabBarController(coordinators: coordinators)
        print("init tab router")
    }
    
    deinit {
        print("deinit tab router")
    }
    
    private func setupTabBarController(coordinators: [any Coordinator]) {
        let views = coordinators.compactMap { $0.router.navigationController }
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = views
        self.tabBarController = tabBarController
    }
    
    func setSelectedIndex(_ index: Int) {
        tabBarController?.selectedIndex = index
    }
    
    func moveView(tabIndex: Int, view: any View) {
        coordinators[tabIndex].router.push(view: view)
    }
}

struct NSTabView: UIViewControllerRepresentable {
    weak var router: NSTabRouter?
    
    func makeUIViewController(context: Context) -> UITabBarController {
        return router?.tabBarController ?? UITabBarController()
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) { }
}
