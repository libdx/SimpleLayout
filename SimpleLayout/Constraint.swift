//
//  Constraint.swift
//  SimpleLayout
//
//  Created by Alexander Ignatenko on 05/07/14.
//  Copyright (c) 2014 Alexander Ignatenko. All rights reserved.
//

#if os(OSX)
    import AppKit
#elseif os(iOS)
    import UIKit
#endif

class ConstraintValue {

    unowned let constraint: Constraint
    let attribute: NSLayoutAttribute
    let relation: NSLayoutRelation?
    var multiplier: Float = 1
    var constant: Float = 0

    init(constraint: Constraint, attribute: NSLayoutAttribute) {
        self.constraint = constraint
        self.attribute = attribute
    }
}

class Constraint {

    let view: UIView
    var value: ConstraintValue!

    init(view: UIView) {
        self.view = view
    }

    var left: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Left)
        return self.value
    }
    }

    var right: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Right)
        return self.value
    }
    }

    var top: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Top)
        return self.value
    }
    }

    var bottom: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Bottom)
        return self.value
    }
    }

    var leading: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Leading)
        return self.value
    }
    }

    var trailing: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Trailing)
        return self.value
    }
    }

    var width: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Width)
        return self.value
    }
    }

    var height: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Height)
        return self.value
    }
    }

    var centerX: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .CenterX)
        return self.value
    }
    }

    var centerY: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .CenterY)
        return self.value
    }
    }

    var baseline: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .Baseline)
        return self.value
    }
    }

    var firstBaseline: ConstraintValue {
    get {
        self.value = ConstraintValue(constraint: self, attribute: .FirstBaseline)
        return self.value
    }
    }

    func create(rightValue: ConstraintValue, relation: NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.view,
            attribute: self.value.attribute,
            relatedBy: relation,
            toItem: rightValue.constraint.view,
            attribute: rightValue.attribute,
            multiplier: rightValue.multiplier,
            constant: rightValue.constant)
    }

    class func make(
        view1: UIView,
        view2: UIView,
        formula: (c1: Constraint, c2: Constraint) -> NSLayoutConstraint
        ) -> NSLayoutConstraint {

            return formula(c1: Constraint(view: view1), c2: Constraint(view: view2))
    }

}

func == (left: ConstraintValue, right: ConstraintValue) -> NSLayoutConstraint {
    return left.constraint.create(right, relation: .Equal)
}

func <= (left: ConstraintValue, right: ConstraintValue) -> NSLayoutConstraint {
    return left.constraint.create(right, relation: .LessThanOrEqual)
}

func >= (left: ConstraintValue, right: ConstraintValue) -> NSLayoutConstraint {
    return left.constraint.create(right, relation: .GreaterThanOrEqual)
}

func + (attribute: ConstraintValue, constant: Float) -> ConstraintValue {
    attribute.constant = constant
    return attribute
}

func * (attribute: ConstraintValue, multiplier: Float) -> ConstraintValue {
    attribute.multiplier = multiplier
    return attribute
}
