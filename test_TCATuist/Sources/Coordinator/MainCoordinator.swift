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
    
    init<T: View>(parent: (any Coordinatable)? = nil, baseView: T) {
        self.parentCoordinator = parent
        self.controller = NSNavigationController(baseView: baseView)
        print("init coordinator")
    }
    
    init(parent: (any Coordinatable)? = nil, router: NSNavigationController) {
        self.parentCoordinator = parent
        self.controller = router
        print("init coordinator")
    }
    
    deinit {
        print("deinit coordinator")
    }
    
    var rootView: some View {
        NSNavigationView(router: controller).environmentObject(self)
    }
    
    func aView() {
        let view = AView()
        controller.push(view: view)
    }
    
    func bView() {
        let view = BView()
        controller.push(view: view)
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
