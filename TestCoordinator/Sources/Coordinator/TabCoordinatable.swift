//
//  TabCoordinatable.swift
//  NSCoordinatorMain
//
//  Created by 김남수 on 2023/01/13.
//  Copyright © 2023 ns. All rights reserved.
//

import SwiftUI

/// 탭바 생성시 사용해야합니다
protocol TabCoordinatable: ObservableObject {
    associatedtype Content: View
    
    var controller: NSTabController? { get set }
    var defaultView: Self.Content { get }
}
