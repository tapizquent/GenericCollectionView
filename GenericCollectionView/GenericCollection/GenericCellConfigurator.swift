//
//  CellConfigurator.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

protocol GenericCellConfigurator {
    static var reuseId: String { get }
    static var defaultCellSize: CGSize? { get }
    func configure(cell: UIView)
    func register(in: UICollectionView)
}

class CollectionCellConfigurator<CellType: GenericConfigurableCell, DataType>: GenericCellConfigurator where CellType.DataType == DataType, CellType: UICollectionReusableView {
    
    static var reuseId: String { return CellType.reuseIdentifier }
    
    let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
    
    func register(in collectionView: UICollectionView) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: String(describing: CellType.self))
    }
    
    public static var defaultCellSize: CGSize? {
        return CellType.defaultCellSize
    }
}
