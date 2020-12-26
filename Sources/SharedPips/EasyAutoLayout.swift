//
//  EasyAutoLayout.swift
//
//
//  Created by Ethan Pippin on 12/25/20.
//  Copyright © 2020 Ethan Pippin. All rights reserved.
//
#if !os(macOS)
import Foundation
import UIKit

infix operator ⩵ : MultiplicationPrecedence
infix operator × : BitwiseShiftPrecedence

public func ⩵ <AnchorType>(left: NSLayoutAnchor<AnchorType>, right: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint {
    return left.constraint(equalTo: right)
}

public func ⩵(left: NSLayoutDimension, right: ConstraintMultiplier) -> NSLayoutConstraint {
    return left.constraint(equalTo: right.anchor, multiplier: right.multiplier)
}

public func ⩵(left: NSLayoutDimension, right: CGFloat) -> NSLayoutConstraint {
    return left.constraint(equalToConstant: right)
}

extension NSLayoutConstraint {
    public func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}

public class ConstraintMultiplier  {
    let anchor: NSLayoutDimension
    let multiplier: CGFloat
    
    init(anchor: NSLayoutDimension, multiplier: CGFloat) {
        self.anchor = anchor
        self.multiplier = multiplier
    }
}

public func ×(left: NSLayoutDimension, right: CGFloat) -> ConstraintMultiplier {
    return ConstraintMultiplier(anchor: left, multiplier: right)
}

public func +(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    left.constant = right
    return left
}

// TODO: Fix this
// Usage: customView.rightAnchor ⩵ view.leftAnchor + (view.widthAnchor × 0.5)
// There is an error on the + when this is used
public func +(left: NSLayoutConstraint, right: ConstraintMultiplier) -> CGFloat {
    return (right.anchor.constraint(equalToConstant: right.multiplier) + left.constant).constant
}

public func -(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    left.constant = -right
    return left
}

extension UIView {
    public class func forAutoLayout() -> Self {
        let view = self.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    public func setAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func embed(_ childView: UIView, inset: UIEdgeInsets = .zero) {
        addSubview(childView)
        NSLayoutConstraint.activate([
            childView.topAnchor ⩵ self.safeAreaLayoutGuide.topAnchor + inset.top,
            childView.leftAnchor ⩵ self.leftAnchor + inset.left,
            childView.bottomAnchor ⩵ self.safeAreaLayoutGuide.bottomAnchor - inset.bottom,
            childView.rightAnchor ⩵ self.rightAnchor - inset.right
            ])
    }
}
#endif
