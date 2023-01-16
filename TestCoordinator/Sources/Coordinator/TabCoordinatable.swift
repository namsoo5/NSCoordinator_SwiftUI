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
    
    /**
     탭의 최초뷰를 보여주는 부분으로,
     자기자신과 탭별 enviromentObject 정의해줘야합니다
     
     ``` swift
     // Usage
     NSTabView(controller: controller)
     .environmentObject(self)
     .environmentObject(aCoordinator)
     ...
     ```
     */
    var defaultView: Self.Content { get }
}
