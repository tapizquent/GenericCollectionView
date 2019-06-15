//
//  BigColorVC.swift
//  GenericCollectionView
//
//  Created by Jose Tapizquent on 6/15/19.
//  Copyright © 2019 ICAY Pets, Inc. All rights reserved.
//

import UIKit

class BigColorVC: UIViewController {
    
    var data: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = data
    }
}
