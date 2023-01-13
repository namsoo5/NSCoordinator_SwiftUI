//
//  TabCoordinatable.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

protocol TabCoordinatable: ObservableObject {
    associatedtype Content: View
    
    var router: NSTabController? { get set }
    var rootView: Self.Content { get }
}
