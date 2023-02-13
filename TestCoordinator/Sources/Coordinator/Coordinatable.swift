//
//  Coordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

/// 일반 루트뷰 생성시 사용해야합니다
protocol Coordinatable: ObservableObject {
    associatedtype Content: View
    
    var controller: NSNavigationController { get }
    var parentCoordinator: (any Coordinatable)? { get set }
    var rootView: Self.Content { get }
    
    init(parent: (any Coordinatable)?, baseView: some View, tabBarItem: UITabBarItem?)
    
    func push(_ view: some View)
    func pop()
    
    func present(_ view: some View)
    func dismiss()
}

extension Coordinatable {
    var parentCoordinator: (any Coordinatable)? { nil }
    var rootView: some View {
        NSNavigationView(controller: controller).environmentObject(self)
    }
    func push(_ view: some View) { }
    func pop() { }
    func present(_ view: some View) { }
    func dismiss() { }
}
