//
//  Coordinator.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

protocol Coordinatable: ObservableObject {
    associatedtype Content: View
    
    var controller: NSNavigationController { get }
    var parentCoordinator: (any Coordinatable)? { get set }
    var rootView: Self.Content { get }
}

extension Coordinatable {
    var parentCoordinator: (any Coordinatable)? { nil }
}
