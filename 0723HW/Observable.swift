//
//  Observable.swift
//  0723HW
//
//  Created by Jimin on 8/13/25.
//

import Foundation

class Observable<T> {
    
    private var action: ((T) -> Void)?
    
    var value: T {
        didSet {
            action?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.action = closure
    }
}
