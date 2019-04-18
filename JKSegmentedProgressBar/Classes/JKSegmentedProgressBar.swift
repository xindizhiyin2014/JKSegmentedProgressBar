//
//  JKSegmentedProgressBar.swift
//  JKSegmentedProgressBar
//
//  Created by JackLee on 2019/4/18.
//

import Foundation
import UIKit

class JKSegmentedProgressBar: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var _itemCount:NSInteger = 1
    var itemCount:NSInteger{
        set{
            if _itemCount != newValue {
                _itemCount = newValue
                itemConfig = ["color":itemForgroundColor,"bgColor":itemBgColor]
            }
        
        }
        
        get{
            return _itemCount
        }
        
    }
    
    var _itemForgroundColor:UIColor = .white
    var itemForgroundColor:UIColor{
        set{
            if _itemForgroundColor != newValue {
                _itemForgroundColor = newValue
                itemConfig = ["color":itemForgroundColor,"bgColor":itemBgColor]
            }
           
        }
        get{
            return _itemForgroundColor
        }
    }
    
    var _itemBgColor:UIColor = UIColor.white.withAlphaComponent(0.3)
    var itemBgColor:UIColor{
        set{
            if _itemBgColor != newValue {
                _itemBgColor = newValue
                itemConfig = ["color":itemForgroundColor,"bgColor":itemBgColor]
            }
        }
        get{
         return _itemBgColor
        }
    }
    var itemSpace:CGFloat = 2
    var itemConfig:NSDictionary
    override init(frame: CGRect) {
        itemConfig = ["color":_itemForgroundColor,"bgColor":_itemBgColor]
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.collectionView.frame = self.bounds;
    }
    //    MARK: - - - - UICollectionViewDataSource - - - -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return self.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:JKSegmentedProgressColletionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "JKSegmentedProgressColletionCellID", for: indexPath) as! JKSegmentedProgressColletionCell
        cell.updateView(withModel: itemConfig)
        return cell
    }
    
    
    //    MARK: - - - - UICollectionViewDelegateFlowLayout - - - -
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = (self.bounds.width - CGFloat(self.itemCount - 1) * self.itemSpace)/CGFloat(self.itemCount)
        return CGSize.init(width: width, height: self.bounds.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return self.itemSpace
    }
    
    public  func updateProgress(indexPath:IndexPath,progress:CGFloat) -> Void{
        let cell:JKSegmentedProgressColletionCell = self.collectionView.cellForItem(at: indexPath) as! JKSegmentedProgressColletionCell
        cell.progress = progress
        UIView.performWithoutAnimation {
         self.collectionView.reloadItems(at: [indexPath])
        }
        
    }

    

    private lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let tmpCollectionView:UICollectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        tmpCollectionView.register(JKSegmentedProgressColletionCell.self, forCellWithReuseIdentifier: "JKSegmentedProgressColletionCellID")
        tmpCollectionView.dataSource = self
        tmpCollectionView.delegate = self
        tmpCollectionView.allowsSelection = false
        tmpCollectionView.isScrollEnabled = false
        tmpCollectionView.bounces = false
        self.addSubview(tmpCollectionView)
        return tmpCollectionView
    }()
    
}

