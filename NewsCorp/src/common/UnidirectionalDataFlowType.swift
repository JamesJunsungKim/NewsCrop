//
//  UnidirectionalDataFlowType.swift
//  NewsCorp
//
//  Created by James Kim on 11/25/23.
//

import Foundation

protocol UnidirectionalDataFlowType {
    associatedtype InputType
    
    func apply(_ input: InputType)
}
