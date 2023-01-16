//
//  Router.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/11.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

/// 네비게이션 기능을 담당합니다
final class NSNavigationController {
    enum BarItemDirection {
        case leading, trailing
    }
    
    private(set) var navigationController: UINavigationController?
    let baseView: AnyView
    let tabBarItem: UITabBarItem?
    
    init<Content: View>(baseView: Content, tabBarItem: UITabBarItem? = nil) {
        self.baseView = AnyView(baseView)
        self.tabBarItem = tabBarItem
        print("init router")
        setupNavigation()
    }
    
    deinit {
        print("deinit router")
    }
    
    private func setupNavigation() {
        let rootViewController = UIHostingController(rootView: baseView)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem = tabBarItem
        self.navigationController = navigationController
    }
    
    func push<Content: View>(view: Content) {
        let viewController = UIHostingController(rootView: view)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present<Content: Coordinatable>(coordinator: Content) {
        let baseView = coordinator.rootView.environmentObject(coordinator)
        let viewController = UIHostingController(rootView: baseView)
        viewController.hidesBottomBarWhenPushed = true
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.present(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
    
    func setViews<Content: View>(_ views: [Content]) {
        let viewControllers = views.map { UIHostingController(rootView: $0) }
        navigationController?.setViewControllers(viewControllers, animated: true)
    }
    
    func popToRootView() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setTitle(_ title: String, color: UIColor) {
        navigationController?.visibleViewController?.title = title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    
    func setBarButtonItems(direction: BarItemDirection, items: [UIBarButtonItem] = []) {
        if direction == .trailing {
            navigationController?.visibleViewController?.navigationItem.setRightBarButtonItems(items, animated: true)
        } else {
            navigationController?.visibleViewController?.navigationItem.setLeftBarButtonItems(items, animated: true)
        }
    }
    
    func setBackground(color: UIColor) {
        navigationController?.navigationBar.backgroundColor = color
    }
}
