//
//  BCoordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

final class BCoordinator: Coordinatable {
    func pop() {
        controller.pop()
    }
    
    func push(_ view: some View) {
        controller.push(view: view)
    }
    
    var parentCoordinator: (any Coordinatable)?
    var controller: NSNavigationController
    init(parent: (any Coordinatable)?, baseView: some View, tabBarItem: UITabBarItem?) {
        self.parentCoordinator = parent
        self.controller = NSNavigationController(baseView: baseView, tabBarItem: tabBarItem)
    }
}
