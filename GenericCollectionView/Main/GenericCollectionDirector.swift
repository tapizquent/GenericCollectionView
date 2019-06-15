//
//  GenericTableDirector.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

class GenericCollectionDirector: NSObject {
    let collectionView: UICollectionView
    let actionsProxy = GenericCellActionProxy()
    
    private(set) var cells = [GenericCellConfigurator]() {
        didSet {
            self.registerCells(items: cells)
            self.collectionView.reloadData()
        }
    }
    
    init(collectionView: UICollectionView, cells: [GenericCellConfigurator]) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.cells = cells
        self.registerCells(items: cells)
    }
}

extension GenericCollectionDirector: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func registerCells(items: [GenericCellConfigurator]) {
        for item in items {
            item.register(in: collectionView)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellConfigurator = self.cells[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: cellConfigurator).reuseId, for: indexPath)
        cellConfigurator.configure(cell: cell)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cells.count > 0 ? 1 : 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellConfigurator = cells[indexPath.item]
        let typeOfConfig = type(of: cellConfigurator)
        return typeOfConfig.defaultCellSize ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cellConfigurator = self.cells[indexPath.item]
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        self.actionsProxy.invoke(action: .didSelect, cell: cell, configurator: cellConfigurator)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellConfigurator = self.cells[indexPath.item]
        self.actionsProxy.invoke(action: .willDisplay, cell: cell, configurator: cellConfigurator)
    }
    
}
