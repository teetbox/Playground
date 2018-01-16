//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

view.backgroundColor = .white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = view

public struct Animation {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

public extension Animation {
    static func fadeIn(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.alpha = 1 })
    }
    
    static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, closure: { $0.bounds.size = size })
    }
}

public extension UIView {
    func animate(_ animations: [Animation]) {
        guard !animations.isEmpty else {
            return
        }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }, completion: { _ in
            self.animate(animations)
        })
    }
    
    func animate(inParallel animations: [Animation]) {
        animations.forEach { (animation) in
            UIView.animate(withDuration: animation.duration) {
                animation.closure(self)
            }
        }
    }
}

let animationView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

animationView.backgroundColor = .blue
animationView.alpha = 0
view.addSubview(animationView)

animationView.animate([
    .fadeIn(duration: 3),
    .resize(to: CGSize(width: 200, height: 200), duration: 3)
    ])

animationView.animate(inParallel: [
    .fadeIn(duration: 3),
    .resize(to: CGSize(width: 200, height: 200), duration: 3)
    ])

