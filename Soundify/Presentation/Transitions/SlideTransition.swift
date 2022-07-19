//
//  SlideTransition.swift
//  Soundify
//
//  Created by Raul Max on 19/07/22.
//

import Foundation
import UIKit

class SlideTransition: NSObject {
  private var duration: TimeInterval {
    return 0.3
  }
  
  private let viewControllers: [UIViewController]
  
  init(for viewControllers: [UIViewController]) {
    self.viewControllers = viewControllers
    super.init()
  }
}

extension SlideTransition: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
      let fromView = fromVc.view,
      let fromIndex = getIndex(viewController: fromVc),
      let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
      let toView = toVc.view,
      let toIndex = getIndex(viewController: toVc)
    else {
      transitionContext.completeTransition(false)
      return
    }
    
    let frame = transitionContext.initialFrame(for: fromVc)
    var fromFrameEnd = frame
    var toFrameStart = frame
    
    fromFrameEnd.origin.x = toIndex > fromIndex
    ? frame.origin.x - frame.width
    : frame.origin.x + frame.width
    
    toFrameStart.origin.x = toIndex > fromIndex
    ? frame.origin.x + frame.width
    : frame.origin.x - frame.width
    
    toView.frame = toFrameStart
    
    DispatchQueue.main.async {
      transitionContext.containerView.addSubview(toView)
      UIView.animate(
        withDuration: self.duration,
        delay: 0,
        options: .curveEaseInOut,
        animations: {
          fromView.frame = fromFrameEnd
          toView.frame = frame
        },
        completion: { success in
          fromView.removeFromSuperview()
          transitionContext.completeTransition(success)
        })
    }
  }
  
  func getIndex(viewController: UIViewController) -> Int? {
    for (index, thisVc) in self.viewControllers.enumerated() {
      if thisVc == viewController {
        return index
      }
    }
    return nil
  }
}
