//
//  NSNavigationView.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/16.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

/// UIKit -> SwiftUI 네비게이션 뷰
struct NSNavigationView: UIViewControllerRepresentable {
    weak var controller: NSNavigationController?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        return controller?.navigationController ?? UINavigationController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
