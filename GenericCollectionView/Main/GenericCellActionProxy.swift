//
//  CellActionProxy.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

enum GenericCellAction: Hashable {
    case didSelect
    case willDisplay
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .didSelect: hasher.combine(0)
        case .willDisplay: hasher.combine(1)
        }
    }
    
    static func ==(lhs: GenericCellAction, rhs: GenericCellAction) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class GenericCellActionProxy {
    //storage where subscribers' closures are stored
    private var actions = [String: ((GenericCellConfigurator, UIView) -> Void)]()
    
    //method to invoke cell action and notify all subscribers
    func invoke(action: GenericCellAction, cell: UIView, configurator: GenericCellConfigurator) {
        let key = "\(action.hashValue)\(type(of: configurator).reuseId)"
        if let action = self.actions[key] {
            action(configurator, cell)
        }
    }
    
    //subscribe to cell action. returning self to chain subscriptions
    @discardableResult
    func on<CellType, DataType>(_ action: GenericCellAction, handler: @escaping ((CollectionCellConfigurator<CellType, DataType>, CellType) -> Void)) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { (c, cell) in
            handler(c as! CollectionCellConfigurator<CellType, DataType>, cell as! CellType)
        }
        return self
    }
}
