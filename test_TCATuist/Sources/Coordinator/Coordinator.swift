//
//  Coordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype Content: View
    var controller: NSNavigationController { get }
    var rootView: Self.Content { get }
}
