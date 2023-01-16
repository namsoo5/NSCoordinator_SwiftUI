//
//  MainCoordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

final class MainCoordinator: Coordinatable {
    let controller: NSNavigationController
    var parentCoordinator: (any Coordinatable)?
    
    init(parent: (any Coordinatable)? = nil, baseView: any View, tabBarItem: UITabBarItem? = nil) {
        self.parentCoordinator = parent
        self.controller = NSNavigationController(baseView: baseView, tabBarItem: tabBarItem)
        print("init coordinator")
    }
    
    deinit {
        print("deinit coordinator")
    }
    
    func aView() {
        let view = AView()
        controller.push(view: view)
    }
    
    func bView() {
        let bCoordinator = BCoordinator(parent: self, baseView: BView(), tabBarItem: nil)
        controller.present(coordinator: bCoordinator)
    }
    
    func cView() {
        let coordinator = MainCoordinator(parent: self, baseView: MainView())
        controller.present(coordinator: coordinator)
    }
    
    func moveParentView() {
        parentCoordinator?.controller.push(view: AView())
    }
    
    func setViews<Content: View>(_ views: [Content]) {
        controller.setViews(views)
    }
    
    func popToRootView() {
        controller.popToRootView()
    }
}
