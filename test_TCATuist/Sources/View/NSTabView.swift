//
//  NSTabView.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/16.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

/// UIKit -> SwiftUI 텝바 뷰
/// 해당타입에 environmentObject 추가해줘야합니다
struct NSTabView: UIViewControllerRepresentable {
    weak var controller: NSTabController?
    
    func makeUIViewController(context: Context) -> UITabBarController {
        controller?.tabBarController?.delegate = context.coordinator
        return controller?.tabBarController ?? UITabBarController()
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
