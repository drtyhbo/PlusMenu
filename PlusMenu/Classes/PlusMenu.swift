//
//  PlusMenu.swift
//  PlusMenu
//
//  Created by Andreas Binnewies on 5/11/15.
//  Copyright (c) 2015 drtyhbo. All rights reserved.
//

import Foundation

@IBDesignable public class PlusMenu: UIView {
    // MARK: IBInspectable
    @IBInspectable var mainButtonBackgroundColor: UIColor = UIColor.blackColor() {
        didSet {
            mainButton.backgroundColor = mainButtonBackgroundColor
        }
    }
    @IBInspectable var mainButtonForegroundColor: UIColor = UIColor.whiteColor() {
        didSet {
            mainButton.tintColor = mainButtonForegroundColor
        }
    }

    @IBInspectable var secondaryButtonBackgroundColor: UIColor = UIColor.blackColor()
    @IBInspectable var secondaryButtonForegroundColor: UIColor = UIColor.whiteColor()

    @IBInspectable var plusImage: UIImage? = UIImage(named: "Plus.png") {
        didSet {
            if plusImage != nil {
                mainButton.setImage(
                    plusImage!.imageWithRenderingMode(.AlwaysTemplate),
                    forState: .Normal)
            }
        }
    }

    @IBInspectable var buttonSpacing: CGFloat = 10

    // MARK: Private variables
    private var secondaryButtonsContainer: UIView!

    private var mainButton: UIButton!
    private var secondaryButtons: [UIButton] = []

    private var expanded: Bool = false

    // MARK: init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createMainButton()
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createMainButton()
    }

    private func createMainButton() {
        mainButton = createButtonAtFrame(
            bounds,
            withImage: plusImage,
            backgroundColor: mainButtonBackgroundColor,
            foregroundColor: mainButtonForegroundColor)
        mainButton.addTarget(
            self,
            action: Selector("tapMainButton"),
            forControlEvents: .TouchUpInside)

        addSubview(mainButton)
    }

    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        mainButton.frame = bounds
        layer.cornerRadius = bounds.size.height / 2
    }

    public override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        for secondaryButton in secondaryButtons {
            if CGRectContainsPoint(secondaryButton.frame, point) {
                return true
            }
        }
        return super.pointInside(point, withEvent: event)
    }

    // MARK: Button management
    private func createButtonAtFrame(
            frame: CGRect,
            withImage image: UIImage?,
            backgroundColor: UIColor,
            foregroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.frame = frame

        if image != nil {
            button.setImage(image!.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        }
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        button.backgroundColor = backgroundColor
        button.tintColor = foregroundColor

        button.layer.masksToBounds = true
        button.layer.cornerRadius = frame.size.height / 2

        return button
    }

    public func createSecondaryButtonWithImage(image: UIImage) -> UIButton {
        if secondaryButtonsContainer == nil {
            secondaryButtonsContainer = UIView(
                frame: CGRect(x: 0, y: 0, width: 200, height: bounds.size.height))
            insertSubview(secondaryButtonsContainer, atIndex: 0)
        }

        let buttonWidth = bounds.size.width
        let buttonHeight = bounds.size.height
        let button = createButtonAtFrame(
            CGRect(
                x: 0,
                y: 0,
                width: buttonWidth,
                height: buttonHeight),
            withImage: image,
            backgroundColor: secondaryButtonBackgroundColor,
            foregroundColor: secondaryButtonForegroundColor)

        secondaryButtons.append(button)
        secondaryButtonsContainer.insertSubview(button, atIndex: 0)

        return button
    }

    // MARK: Events
    func tapMainButton() {
        expanded = !expanded
        self.secondaryButtonsContainer.frame.size.width =
            expanded ?
                (CGFloat(secondaryButtons.count + 1) * (bounds.size.width + buttonSpacing)) :
                0

        UIView.animateWithDuration(0.25) {
            self.mainButton.transform = self.expanded ? CGAffineTransformMakeRotation(CGFloat(M_PI_2 / 2.0)) : CGAffineTransformMakeRotation(0)

            for var i = 0; i < self.secondaryButtons.count; i++ {
                let button = self.secondaryButtons[i]
                button.frame.origin.x = self.expanded ?
                    (CGFloat(i + 1) * (self.bounds.size.width + self.buttonSpacing)) :
                    0
            }
        }
    }
}