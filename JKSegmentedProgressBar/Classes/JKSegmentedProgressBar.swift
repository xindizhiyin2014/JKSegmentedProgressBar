//
//  JKSegmentedProgressBar.swift
//  JKSegmentedProgressBar
//
//  Created by JackLee on 2019/4/18.
//

import Foundation
import UIKit

@objcMembers open class JKSegmentedProgressBar: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    var _itemCount:NSInteger = 1
   public var itemCount:NSInteger{
        set{
            if _itemCount != newValue {
                _itemCount = newValue
                itemConfig = ["color":itemForgroundColor,"bgColor":itemBgColor]
                self.reset = true
                self.collectionView.reloadData()
            }
        
        }
        
        get{
            return _itemCount
        }
        
    }
    
    var _itemForgroundColor:UIColor = .white
   public var itemForgroundColor:UIColor{
        set{
            if _itemForgroundColor != newValue {
                _itemForgroundColor = newValue
                itemConfig = ["color":itemForgroundColor,"bgColor":itemBgColor]
                self.reset = true
                self.collectionView.reloadData()
            }
           
        }
        get{
            return _itemForgroundColor
        }
    }
    
    var _itemBgColor:UIColor = UIColor.white.withAlphaComponent(0.3)
   public var itemBgColor:UIColor{
        set{
            if _itemBgColor != newValue {
                _itemBgColor = newValue
                itemConfig = ["color":itemForgroundColor,"bgColor":itemBgColor]
                self.reset = true
                self.collectionView.reloadData()
            }
        }
        get{
         return _itemBgColor
        }
    }
    var _itemSpace:CGFloat = 2
   public var itemSpace:CGFloat{
        set{
            if _itemSpace != newValue {
                _itemSpace = newValue
                self.reset = true
                self.collectionView.reloadData()
            }
        }
        
        get{
          return _itemSpace
        }
    }
    
    var progress:CGFloat?
    var indexPath:IndexPath?
    var reset:Bool = false
    
    
    
    
    var itemConfig:NSDictionary
    override public init(frame: CGRect) {
        itemConfig = ["color":_itemForgroundColor,"bgColor":_itemBgColor]
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.collectionView .reloadData()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func layoutSubviews() {
        self.collectionView.frame = self.bounds;
    }
    
    //    MARK: - - - - UICollectionViewDataSource - - - -
   public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.itemCount
    }
    
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:JKSegmentedProgressColletionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JKSegmentedProgressColletionCellID", for: indexPath) as! JKSegmentedProgressColletionCell
    if self.reset == true {
      cell.progress = 0
      cell.updateView(withModel: itemConfig)

    }else{
        if self.indexPath == indexPath {
            cell.progress = self.progress ?? 0
        }
    }
    
    return cell
    }
    
    
    //    MARK: - - - - UICollectionViewDelegateFlowLayout - - - -
   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = (self.bounds.width - CGFloat(self.itemCount - 1) * self.itemSpace)/CGFloat(self.itemCount)
        return CGSize.init(width: width, height: self.bounds.height)
    }
    
    
   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
    }
    
   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return self.itemSpace
    }
    
    
   public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    
   public func updateProgress(indexPath:NSIndexPath,progress:CGFloat) -> Void{
    self.indexPath = indexPath as IndexPath
    self.progress = progress
    self.reset = false
        UIView.performWithoutAnimation {
            self.collectionView.reloadItems(at: [indexPath as IndexPath])
        }
    
    }


    private lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let tmpCollectionView:UICollectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        tmpCollectionView.register(JKSegmentedProgressColletionCell.self, forCellWithReuseIdentifier: "JKSegmentedProgressColletionCellID")
        tmpCollectionView.dataSource = self
        tmpCollectionView.delegate = self
        tmpCollectionView.showsHorizontalScrollIndicator = false
        tmpCollectionView.allowsSelection = false
        tmpCollectionView.isScrollEnabled = false
        tmpCollectionView.bounces = false
        tmpCollectionView.backgroundColor = .clear
        self.addSubview(tmpCollectionView)
        return tmpCollectionView
    }()
    
}

