//
//  XibView.swift
//
//  Created by Julián Alonso Carballo on 6/10/16.
//  MIT License

import Foundation

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
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
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
    
}
