//
//  Dictionary+Fixtures.swift
//  nope-analytics
//
//  Created by Jose Maria Marquez on 18/10/25.
//

extension Dictionary where Key == String, Value == Any {
    static func fixture() -> [String: Any] {
        return [
            "key1": "value1",
            "key2": 2,
            "key3": true,
        ]
    }
}
