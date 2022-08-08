//
//  Utilities.swift
//  JobimFinal
//
//  Created by Arkadiy Akimov on 20/07/2022.
//

import UIKit

class Utility {
    
    func randomColor () -> UIColor {
        return UIColor(hue: CGFloat.random(in: 0...1), saturation: 0.7, brightness: 0.7, alpha: 1)
    }
    
    public func constrainEquallyWithin
    (_ parent:UIView,_ child:UIView ,_ margin: CGFloat,_ isSafeAreaRestricted:Bool ) -> [NSLayoutConstraint]{
         
        var constraintGroup = [NSLayoutConstraint]()
        
        if isSafeAreaRestricted {
         constraintGroup = constrainWithinSpecific(
            child,
            parent.safeAreaLayoutGuide.topAnchor , margin,
            parent.safeAreaLayoutGuide.leadingAnchor, margin,
            parent.safeAreaLayoutGuide.trailingAnchor, -margin ,
            parent.safeAreaLayoutGuide.bottomAnchor, -margin)
        } else {
           constraintGroup = constrainWithinSpecific(
                child,
                parent.topAnchor , margin,
                parent.leadingAnchor, margin,
                parent.trailingAnchor, -margin ,
                parent.bottomAnchor, -margin)
        }
        
        return constraintGroup
    }
    
    public func constrainEquallyWithinVoid
    (_ parent:UIView,_ child:UIView ,_ margin: CGFloat,_ isSafeAreaRestricted:Bool ){
        
        if isSafeAreaRestricted {
         _ = constrainWithinSpecific(
            child,
            parent.safeAreaLayoutGuide.topAnchor , margin,
            parent.safeAreaLayoutGuide.leadingAnchor, margin,
            parent.safeAreaLayoutGuide.trailingAnchor, -margin ,
            parent.safeAreaLayoutGuide.bottomAnchor, -margin)
        } else {
           _ = constrainWithinSpecific(
                child,
                parent.topAnchor , margin,
                parent.leadingAnchor, margin,
                parent.trailingAnchor, -margin ,
                parent.bottomAnchor, -margin)
        }
    }
    
    public func constrainWithinSpecific
    (_ target:UIView,
     _ topAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>,_ topMargin:CGFloat,
     _ leadingAnchor:NSLayoutAnchor<NSLayoutXAxisAnchor>,_ leadingMargin:CGFloat,
     _ trailingAnchor:NSLayoutAnchor<NSLayoutXAxisAnchor>,_ trailingMargin:CGFloat,
     _ bottomAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>,_ bottomMargin:CGFloat) -> [NSLayoutConstraint] {
        
        target.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintGroup = [NSLayoutConstraint]()
        constraintGroup.append(target.topAnchor.constraint(equalTo: topAnchor,constant:topMargin))
        constraintGroup.append(target.leadingAnchor.constraint(equalTo: leadingAnchor,constant:leadingMargin))
        constraintGroup.append(target.trailingAnchor.constraint(equalTo: trailingAnchor,constant:trailingMargin))
        constraintGroup.append(target.bottomAnchor.constraint(equalTo: bottomAnchor,constant:bottomMargin))
        
        for i in 0...(constraintGroup.count-1) {
            constraintGroup[i].isActive = true
        }
        
        return constraintGroup
    }
    
    public func constrainWithinSpecificVoid
    (_ target:UIView,
     _ topAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>,_ topMargin:CGFloat,
     _ leadingAnchor:NSLayoutAnchor<NSLayoutXAxisAnchor>,_ leadingMargin:CGFloat,
     _ trailingAnchor:NSLayoutAnchor<NSLayoutXAxisAnchor>,_ trailingMargin:CGFloat,
     _ bottomAnchor:NSLayoutAnchor<NSLayoutYAxisAnchor>,_ bottomMargin:CGFloat){
        
        target.translatesAutoresizingMaskIntoConstraints = false
        
        var constraintGroup = [NSLayoutConstraint]()
        constraintGroup.append(target.topAnchor.constraint(equalTo: topAnchor,constant:topMargin))
        constraintGroup.append(target.leadingAnchor.constraint(equalTo: leadingAnchor,constant:leadingMargin))
        constraintGroup.append(target.trailingAnchor.constraint(equalTo: trailingAnchor,constant:trailingMargin))
        constraintGroup.append(target.bottomAnchor.constraint(equalTo: bottomAnchor,constant:bottomMargin))
        
        for i in 0...(constraintGroup.count-1) {
            constraintGroup[i].isActive = true
        }
    }
    
}
