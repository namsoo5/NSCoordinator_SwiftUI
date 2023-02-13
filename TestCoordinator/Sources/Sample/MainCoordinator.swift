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
    
    init(parent: (any Coordinatable)? = nil, baseView: some View, tabBarItem: UITabBarItem? = nil) {
        self.parentCoordinator = parent
        self.controller = NSNavigationController(baseView: baseView, tabBarItem: tabBarItem)
        print("init coordinator")
    }
    
    deinit {
        print("deinit coordinator")
    }
    func push(_ view: some View) {
        controller.push(view: view)
    }
    func pushAView() {
        controller.push(view: AView())
    }
    
    func setViews(_ views: [some View]) {
        controller.setViews(views)
    }
    @objc
    func popToRootView() {
        controller.popToRootView()
    }
    
    func setupTitle(_ title: String) {
        controller.setTitle(title, color: .blue)
        controller.setBarButtonItems(
            direction: .leading,
            items: [
                UIBarButtonItem(systemItem: .add)
            ]
        )
        controller.setBackground(color: .gray)
    }
    
    func navigationHidden() {
        controller.setNavigationBarHidden(isHidden: true)
    }
    
    func navigationAttributeTitle(title: String) {
        let attribute = NSMutableAttributedString(
            string: title,
            attributes: [
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.black
            ]
        )
        attribute.append(
            NSMutableAttributedString(
                string: "30",
                attributes: [
                    .foregroundColor: UIColor.purple,
                    .font: UIFont.systemFont(ofSize: 16)
                ]
            )
        )
        controller.setTitle(attributedString: attribute)
    }
    
    func setBackButton() {
        controller.setBackButtonHidden(isHidden: true)
        controller.setBarButtonItems(direction: .leading, items: [
            UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(popToRootView))
        ])
    }
    
    func setMultilineTitle(first: String, second: String) {
        
        let secondText = NSAttributedString(string: "\n\(second)", attributes: [.foregroundColor: UIColor.gray])
        let attribute = NSMutableAttributedString(string: first, attributes: [.foregroundColor: UIColor.gray])
        attribute.append(secondText)
        controller.setMultilineTitle(attributedString: attribute)
    }
}
