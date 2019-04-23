//
//  JKSegmentedProgressColletionCell.swift
//  JKSegmentedProgressBar
//
//  Created by JackLee on 2019/4/18.
//

import Foundation
import UIKit

class JKSegmentedProgressColletionCell: UICollectionViewCell {
    var _progress:CGFloat = 0
    public var progress:CGFloat{
        set{
            if newValue.isNaN == false {
                _progress = newValue
                self.progressView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width * newValue, height: self.bounds.height)
            }
          
        }
        get{
            return _progress
        }
    }
    
    
    func updateView(withModel model:NSDictionary) -> Void {
        let bgColor:UIColor = model.object(forKey: "bgColor") as! UIColor
        let color:UIColor = model.object(forKey: "color") as! UIColor
        self.contentView.backgroundColor = bgColor;
        self.progressView.backgroundColor = color;
    }
    
    private lazy var progressView:UIView = {
        let tmpView = UIView.init()
        self.contentView.addSubview(tmpView)
        return tmpView;
    }()
}
