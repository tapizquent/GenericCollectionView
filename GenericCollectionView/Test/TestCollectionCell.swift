//
//  TestCollectionCell.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

class TestCollectionCell: UICollectionViewCell, ConfigurableCell {
    
    static var defaultCellSize: CGSize? = CGSize(width: UIScreen.main.bounds.width, height: 150)
    
    func configure(data: UIColor) {
        backgroundColor = data
    }
}
