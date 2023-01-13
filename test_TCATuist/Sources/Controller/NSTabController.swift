//
//  TabRouter.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/12.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

final class NSTabController {
    private(set) var tabBarController: UITabBarController?
    let coordinators: [any Coordinatable]
    
    init(coordinators: [any Coordinatable]) {
        self.coordinators = coordinators
        setupTabBarController(coordinators: coordinators)
        print("init tab router")
    }
    
    deinit {
        print("deinit tab router")
    }
    
    private func setupTabBarController(coordinators: [any Coordinatable]) {
        let views = coordinators.compactMap { $0.controller.navigationController }
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = views
        self.tabBarController = tabBarController
    }
    
    func setSelectedIndex(_ index: Int) {
        tabBarController?.selectedIndex = index
    }
    
    func moveView(tabIndex: Int, view: any View) {
        coordinators[tabIndex].controller.push(view: view)
    }
}

/// UIKit -> SwiftUI 텝바 뷰
/// 해당타입에 environmentObject 추가해줘야합니다
struct NSTabView: UIViewControllerRepresentable {
    weak var router: NSTabController?
    
    func makeUIViewController(context: Context) -> UITabBarController {
        router?.tabBarController?.delegate = context.coordinator
        return router?.tabBarController ?? UITabBarController()
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, UITabBarControllerDelegate {
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print(tabBarController.selectedIndex)
        }
    }
}
