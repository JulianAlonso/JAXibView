//
//  XibView.swift
//
//  Created by Julián Alonso Carballo on 6/10/16.
//  Copyright © 2016 com.Julian. All rights reserved.
//

import UIKit

@IBDesignable
class XibView: UIView {
    
    private var containerView: UIView = UIView()
    private var customConstraints: [NSLayoutConstraint] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.configure()
    }
    
    //Override this if you want execute custom code after init 🤗
    func configure() { }
    
    func commonInit() {
        self.backgroundColor = .clear
        let selfType = type(of: self)
        let objects = Bundle(for: selfType).loadNibNamed("\(selfType)", owner: self, options: nil)
        var view: UIView? = nil
        
        for object in objects! {
            if object is UIView {
                view = object as? UIView
                break
            }
        }
        
        if let view = view {
            self.containerView = view
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            self.setNeedsUpdateConstraints()
        }
    }
    
    //MARK: - Update
    override func updateConstraints() {
        self.removeConstraints(self.customConstraints)
        self.customConstraints = []
        
        let view = self.containerView
        let views = ["view" : view]
        
        self.customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: views))
        self.customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: views))
        
        self.addConstraints(self.customConstraints)
        
        super.updateConstraints()
    }
    
    func superLayout() {
        var view = self.superview
        while view?.superview != nil {
            view = view?.superview
        }
        view?.setNeedsLayout()
        view?.layoutIfNeeded()
    }
}
