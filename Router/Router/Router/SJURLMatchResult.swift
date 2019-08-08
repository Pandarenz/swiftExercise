//
//  SJURLMatchResult.swift
//  Router
//
//  Created by JiWuChao on 2019/8/8.
//  Copyright © 2019 JiWuChao. All rights reserved.
//

import Foundation
/// Represents an URL match result.

public struct SJRouterMatchResult {
    /// The url pattern that was matched.
    public let pattern: String
    
    /// The values extracted from the URL placeholder.
    public let values: [String: Any]
}
