//
//  ViewController.swift
//  O3Mac
//
//  Created by Apisit Toompakdee on 11/19/17.
//  Copyright © 2017 O3. All rights reserved.
//

import Cocoa
import NeoSwift

class ViewController: NSViewController {
    
    
    @IBOutlet var neoLabel: NSTextField!
    @IBOutlet var gasLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let neo = NeoClient(network: .main, seedURL: "http://seed2.neo.org:10332")
        neo.getAccountState(for: "AKcm7eABuW1Pjb5HsTwiq7iARSatim9tQ6") { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                return
            case .success(let accountState):
                DispatchQueue.main.async {
                    for asset in accountState.balances {
                        if asset.id.contains(NeoSwift.AssetId.neoAssetId.rawValue) {
                            self.neoLabel.stringValue = String(format:"%ld", Int(asset.value) ?? 0)
                        } else if asset.id.contains(NeoSwift.AssetId.gasAssetId.rawValue) {
                            self.gasLabel.stringValue = String(format:"%.8f",  Double(asset.value) ?? 0)
                        }
                    }
                }
            }
        }
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

