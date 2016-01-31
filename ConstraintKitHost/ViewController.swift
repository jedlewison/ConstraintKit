//
//  ViewController.swift
//  ConstraintKitHost
//
//  Created by Jed Lewison / Magic App Factory on 1/24/16.
//  MIT License All rights reserved.
//

import UIKit
import ConstraintKit

class ViewController: UIViewController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let vc = NewViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

class NewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let blueView = UIView()
        blueView.backgroundColor = .purpleColor()
        view.addSubview(blueView)
        blueView.clk_edgesAnchor.constraintsEqualTo(view.layoutMarginsGuide)


        let newView = UIView()
        newView.backgroundColor = .redColor()
        view.addSubview(newView)

        NSLayoutConstraint(item: newView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).clk_activate()
        view.centerYAnchor.constraintEqualToAnchor(newView.centerYAnchor).clk_activate()
        newView.widthAnchor.constraintEqualToConstant(100).clk_activate()
        newView.heightAnchor.constraintEqualToConstant(50).clk_activate()

        newView.widthAnchor.constraintEqualToConstant(170).clk_activate()

        let anotherBigView = UIView()
        anotherBigView.backgroundColor = .brownColor()
        view.addSubview(anotherBigView)
        anotherBigView.clk_edgesAnchor.constraintsEqualTo(view).activate()

        let anotherView = UIView()
        anotherView.backgroundColor = .greenColor()
        view.addSubview(anotherView)

        anotherView.clk_edgesAnchor.constraintsEqualTo(view).with(UIEdgeInsets(top: 0, left: 40, bottom: 190, right: 10)).activate()

        let aCenteredGroup = UIView()
        aCenteredGroup.backgroundColor = .orangeColor()
        view.addSubview(aCenteredGroup)
        aCenteredGroup.clk_centerAnchor.constraintsEqualTo(view).activate()
        aCenteredGroup.clk_sizeAnchor.constraintsEqualTo(view).with(multiplier: 0.5).activate()

        view.addSubview(aChangingGroup)

        let newRedView = UIView()
        view.addSubview(newRedView)
        newRedView.backgroundColor = .redColor()
        newRedView.clk_edgesAnchor.constraintsEqualTo(self).with(UIEdgeInsets(top: 310, left: 40, bottom: 0, right: 10)).activate()

        let someViews = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
        someViews.forEach {
            $0.backgroundColor = .greenColor()
        }
        view.addSubview(someViews[0])
        view.addSubview(someViews[1])
        someViews[1].addSubview(someViews[2])
        someViews[2].addSubview(someViews[3])
        someViews[0].addSubview(someViews[4])
        someViews[4].addSubview(someViews[5])
        someViews[3].leftAnchor.constraintEqualToAnchor(view.leftAnchor).clk_activate()
        someViews[3].bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).clk_activate()
        someViews[3].clk_sizeAnchor.constraintsEqualTo(CGSize(width: 75, height: 90)).activate()
        someViews[5].clk_centerAnchor.constraintsEqualTo(view).activate()
        someViews[5].clk_sizeAnchor.constraintsEqualTo(someViews[3]).activate()
        someViews[5].backgroundColor = .blueColor()

        updateConstraints(forSize: view.bounds.size)

    }

    let aChangingGroup: UIView = {
        let theView = UIView()
        theView.backgroundColor = .cyanColor()
        return theView
    }()

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.updateConstraints(forSize: size)
    }




    lazy var theToppestView: UIView = {
        let theView = UIView()
        self.view.addSubview(theView)
        theView.backgroundColor = .yellowColor()
        return theView
    }()


    func updateConstraints(forSize size: CGSize) {

        aChangingGroup.clk_sizeAnchor.constraintsEqualTo(CGSize(width: size.width/4, height: size.height/4)).activate()

        let top = aChangingGroup.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 0)
        let left = aChangingGroup.leftAnchor.constraintEqualToAnchor(view.readableContentGuide.leftAnchor, constant: 0)
        let bottom = aChangingGroup.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: 0)
        let right = aChangingGroup.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: 0)

        if size.width > size.height {
            theToppestView.clk_edgesAnchor.constraintsEqualTo(view.layoutMarginsGuide)?.deactivate()
            let insets = UIEdgeInsets(top: 4, left: 100, bottom: 200, right: 100)
            
            theToppestView.clk_edgesAnchor.constraintsEqualTo(self).with(insets).activate()


            top.clk_deactivate()
            right.clk_deactivate()
            bottom.clk_activate()
            left.clk_activate()
        } else {

            theToppestView.clk_edgesAnchor.constraintsEqualTo(self).deactivate()

            theToppestView.clk_edgesAnchor.constraintsEqualTo(view.layoutMarginsGuide)?.with(UIEdgeInsets(top: 140, left: 250, bottom: 100, right: 40)).activate()
            bottom.clk_deactivate()
            left.clk_deactivate()
            top.clk_activate()
            right.clk_activate()
        }
        view.bringSubviewToFront(theToppestView)
        view.bringSubviewToFront(aChangingGroup)
        view.setNeedsLayout()
    }
}
