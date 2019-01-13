//
//  ViewController.swift
//  anamation practice
//
//  Created by Lova on 2019/1/13.
//  Copyright © 2019 TaxiGo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var blackView: UIView!
    @IBOutlet var blurView: UIView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        blackView.transform = CGAffineTransform(scaleX: 0.67, y: 0.67)
        blackView.alpha = 0

        blurView.alpha = 1
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Animate.scaleUp(view: blackView).startAnimation()

        Animate.fade(view: blurView, visible: false).startAnimation()
    }

    func toggleBlur(_ blurred: Bool) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            self.blurView.alpha = blurred ? 1 : 0
        })
    }

    @IBAction func pressed(_ sender: Any) {
//        Animate.fade(view: v, visible: !v.isVisible)
        Animate.jiggle(view: blackView).startAnimation()
    }
}

//extension UIView {
//    var an: Animate.Type {
//        return Animate.self
//    }
//}

class Animate {
    @discardableResult
    static func scaleUp(view: UIView) -> UIViewPropertyAnimator {
        let scale = UIViewPropertyAnimator(duration: 0.33, curve: .easeIn)

        scale.addAnimations {
            view.alpha = 1.0
        }

        scale.addAnimations({
            view.transform = .identity
        }, delayFactor: 0.33)

        scale.addCompletion { _ in
            print("ready")
        }

        return scale
    }

    @discardableResult
    static func fade(view: UIView, visible: Bool) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: .curveEaseOut, animations: {
            view.alpha = visible ? 1.0 : 0.0
        }, completion: nil)
    }

    @discardableResult
    static func jiggle(view: UIView) -> UIViewPropertyAnimator {
        let animate = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.33, delay: 0, animations: {
            UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
                    view.transform = CGAffineTransform(rotationAngle: -.pi / 8)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75, animations: {
                    view.transform = CGAffineTransform(rotationAngle: +.pi / 8)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1.0, animations: {
                    view.transform = CGAffineTransform.identity
                })
            })
        })

        animate.addCompletion { _ in
            view.transform = .identity
        }

        return animate
    }
}
