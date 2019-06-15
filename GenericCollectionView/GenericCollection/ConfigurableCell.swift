//
//  ConfigurableCell.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

protocol GenericConfigurableCell {
    associatedtype DataType
    static var reuseIdentifier: String { get }
    static var defaultCellSize: CGSize? { get }
    func configure(data: DataType)
}

extension GenericConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}

class EmptyGenericCell: UICollectionReusableView, GenericConfigurableCell {
    static var defaultCellSize: CGSize? = CGSize(width: UIScreen.main.bounds.width, height: 72)
    
    func configure(data: String) {
        backgroundColor = .white
    }
}

typealias EmptyGenericCellConfigurator = CollectionCellConfigurator<EmptyGenericCell, String>


