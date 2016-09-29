//
//  ViewController.swift
//  CheatCodes
//
//  Created by Dave Lyon on 09/09/2016.
//  Copyright (c) 2016 Dave Lyon. All rights reserved.
//

import UIKit
import CheatCodes

class ViewController: UIViewController {

    let firstRunKey = "showedFirstRunView"

    var hasSeenFirstTimeView: Bool {
        get { return UserDefaults.standard.bool(forKey: firstRunKey) }
        set { UserDefaults.standard.set(hasSeenFirstTimeView, forKey: firstRunKey) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if !hasSeenFirstTimeView {
            showFirstTimeView()
        }

        // We need to `opt in` somewhere
        if #available(iOS 9.0, *) {
            addCheatCodes()
        }
    }

    func showFirstTimeView() {
        hasSeenFirstTimeView = true
        // Add a view over the whole main view
        print("Gonna show a view!")
    }

}

extension ViewController: CheatCodeResponder {
    var cheatCodes: [CheatCodeCommand] {
        return [
            CheatCodeCommand(input: UIKeyInputUpArrow, modifierFlags: [.control,.command], action: #selector(showFirstTimeView), discoverabilityTitle: "Show the 'first time' screen")
        ]
    }
}
