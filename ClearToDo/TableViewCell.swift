//
//  TableViewCell.swift
//  ClearToDo
//
//  Created by alex oh on 2/15/16.
//  Copyright © 2016 Alex Oh. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate {
    func toDoItemDeleted(todoItem: ToDoItem)
}

class TableViewCell: UITableViewCell {

    let gradientLayer = CAGradientLayer()
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    
    var delegate: TableViewCellDelegate?
    var toDoItem: ToDoItem?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not suppported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        gradientLayer.frame = bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, atIndex: 0)
        
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .Began {
            originalCenter = center
        }
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
        }
        if recognizer.state == .Ended {
            let originalFrame = CGRect(x: 0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.frame = originalFrame
                })
            }
            if deleteOnDragRelease {
                if delegate != nil && toDoItem != nil {
                    delegate?.toDoItemDeleted(toDoItem!)
                }
            }
        }
    }

    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
}
