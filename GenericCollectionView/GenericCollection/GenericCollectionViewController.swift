//
//  GenericCollectionViewController.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/14/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

protocol GenericCollectionViewModel {
    var header: GenericCellConfigurator { get }
    var footer: GenericCellConfigurator { get }
    var cells: [GenericCellConfigurator] { get }
    var reloadData: ((Bool) -> ())? { get set }
}

open class GenericCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: GenericCollectionViewModel
    var layout: UICollectionViewFlowLayout
    lazy private var collectionDirector: GenericCollectionDirector = {
        return GenericCollectionDirector(collectionView: self.collectionView, cells: self.viewModel.cells)
    }()
    
    init(viewModel: GenericCollectionViewModel) {
        self.viewModel = viewModel
        layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    init(viewModel: GenericCollectionViewModel, layout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel
        self.layout = layout
        super.init(collectionViewLayout: self.layout)
    }
    // Registers cells in given collectionView.
    func registerCells(items: [GenericCellConfigurator]) {
        for item in items {
            item.register(in: collectionView)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = layout
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        self.addHandlers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Here is where subscription takes place.
    // c can be any class than inherits from GenericCellConfigurator
    private func addHandlers() {
        self.collectionDirector.actionsProxy
            .on(.didSelect) { (c: TestCellConfigurator, cell) in
                let bigColorVC = BigColorVC()
                bigColorVC.data = c.item
                self.navigationController?.pushViewController(bigColorVC, animated: true)
            }
    }
}
