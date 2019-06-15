//
//  TestViewModel.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

typealias TestCellConfigurator = CollectionCellConfigurator<TestCollectionCell, UIColor>

class TestViewModel: GenericCollectionViewModel {
    var header: GenericCellConfigurator = EmptyGenericCellConfigurator(item: "Header")
    var footer: GenericCellConfigurator = EmptyGenericCellConfigurator(item: "Footer")
    var cells: [GenericCellConfigurator] = [
        TestCellConfigurator(item: .red),
        TestCellConfigurator(item: .blue),
        TestCellConfigurator(item: .gray),
        TestCellConfigurator(item: .orange),
        TestCellConfigurator(item: .green),
        TestCellConfigurator(item: .brown),
        TestCellConfigurator(item: .cyan)
    ]
    var reloadData: ((Bool) -> ())?
    
    
}
