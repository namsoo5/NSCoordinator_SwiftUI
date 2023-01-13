//
//  Router.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/11.
//  Copyright © 2023 ns. All rights reserved.
//

import Foundation
import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype Content: View
    var router: NSRouter { get }
    var rootView: Self.Content { get }
}

final class MainCoordinator: Coordinator {
    let router: NSRouter
    private var parentCoordinator: (any Coordinator)?
    private var childCoordinator: [any Coordinator] = []
    
    init<T: View>(parent: (any Coordinator)? = nil, baseView: T) {
        self.parentCoordinator = parent
        self.router = NSRouter(baseView: baseView)
        print("init coordinator")
    }
    
    init(parent: (any Coordinator)? = nil, router: NSRouter) {
        self.parentCoordinator = parent
        self.router = router
        print("init coordinator")
    }
    
    deinit {
        print("deinit coordinator")
    }
    
    var rootView: some View {
        NSNavigationView(router: router).environmentObject(self)
    }
    
    func aView() {
        let view = AView()
        router.push(view: view)
    }
    
    func bView() {
        let view = BView()
        router.push(view: view)
    }
    
    func cView() {
        let coordinator = MainCoordinator(parent: self, baseView: MainView())
        childCoordinator.append(coordinator)
        router.present(coordinator: coordinator)
    }
    
    func moveParentView() {
        parentCoordinator?.router.push(view: AView())
    }
    
    func setViews<Content: View>(_ views: [Content]) {
        router.setViews(views)
    }
    
    func popToRootView() {
        router.popToRootView()
    }
}

final class NSRouter: ObservableObject {
    @Published private(set) var navigationController: UINavigationController?
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
    
    func present<Content: Coordinator>(coordinator: Content) {
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

struct NSNavigationView: UIViewControllerRepresentable {
    weak var router: NSRouter?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return router?.navigationController ?? UINavigationController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
