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
