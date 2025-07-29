//
//  ViewDesignProtocol.swift
//  0723HW
//
//  Created by Jimin on 7/23/25.
//

import Foundation

@objc protocol ViewDesignProtocol: AnyObject {
    func configureHierarchy()
    func configureLayout()
    @objc optional func configureView()
}
