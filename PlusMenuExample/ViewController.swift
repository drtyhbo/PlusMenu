//
//  ViewController.swift
//  PlusMenuExample
//
//  Created by Andreas Binnewies on 5/11/15.
//  Copyright (c) 2015 drtyhbo. All rights reserved.
//

import UIKit
import PlusMenu

class ViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var plusMenu: PlusMenu!

    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        let cameraButton = plusMenu.createSecondaryButtonWithImage(UIImage(named: "Camera.png")!)
        cameraButton.addTarget(
            self,
            action: Selector("showCamera"),
            forControlEvents: .TouchUpInside)

        let exerciseButton = plusMenu.createSecondaryButtonWithImage(UIImage(named: "Dumbbell.png")!)
        exerciseButton.addTarget(
            self,
            action: Selector("showExercise"),
            forControlEvents: .TouchUpInside)
    }

    // MARK: Button events
    func showCamera() {
        println("camera")
    }

    func showExercise() {
        println("exercise")
    }
}

