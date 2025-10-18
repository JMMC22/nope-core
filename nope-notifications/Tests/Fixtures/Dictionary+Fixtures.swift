//
//  Dictionary+Fixtures.swift
//  nope-notifications
//
//  Created by Jose Maria Marquez on 18/10/25.
//

import Foundation

extension Dictionary where Key == AnyHashable, Value == Any {
    static func fixture() -> [AnyHashable: Any] {
        [
            "key1": "value1",
            "key2": 2,
            "key3": true,
        ]
    }
}
