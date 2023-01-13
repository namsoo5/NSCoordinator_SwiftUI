//
//  Router.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/11.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

final class NSNavigationController {
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
}

/// UIKit -> SwiftUI 네비게이션 뷰
struct NSNavigationView: UIViewControllerRepresentable {
    weak var controller: NSNavigationController?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return controller?.navigationController ?? UINavigationController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
