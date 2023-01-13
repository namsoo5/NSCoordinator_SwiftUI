//
//  Setting.swift
//  ProjectDescriptionHelpers
//
//  Created by 김남수 on 2023/01/10.
//

import Foundation
import ProjectDescription

// project setting
let baseSettings: [String: SettingValue] = [
    "ENABLE_BITCODE": "NO",
    "Provisioning_Profile": "Automatic",
    "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
    "CODE_SIGN_STYLE": "Automatic",
    "PRODUCT_NAME": "Coordinator",
]

extension Settings {
    public static let projectSettings = Settings.settings(
        base: baseSettings,
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release"),
        ]
    )
    public static let debugSettings = Settings.settings(
        base: baseSettings,
        configurations: [
            .debug(name: "Debug")
        ]
    )
}
