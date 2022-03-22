//
//  Uiview + Ext.swift
//  Netflix
//
//  Created by Oday Dieg on 21/03/2022.
//

import UIKit

extension UIView {
    
    var width: CGFloat{
        return frame.size.width
    }
    
    var height: CGFloat{
        return frame.size.height
    }
    var left: CGFloat{
        return frame.origin.x
    }
    var right: CGFloat{
        return left + width
    }
    var top: CGFloat{
        return frame.origin.y
    }
    var Bottom: CGFloat{
        return top + height
    }
    
}
