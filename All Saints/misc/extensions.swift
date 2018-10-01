//
//  extensions.swift
//  All Saints
//
//  Created by ilyar on 10/1/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

protocol Nameable {}
extension Nameable {
    static var name: String {
        return String(describing: self)
    }
}

protocol XibLoadable: Nameable {
    associatedtype View = UIView
}

extension XibLoadable where Self: UIView {
    
    static var fromXib: View {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! View
    }
}
