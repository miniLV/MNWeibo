//
//  MNEmojiInputView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

let mnKeyboardHeight:CGFloat = 254.0

class MNEmojiInputView: UIView {
    
    let cellID = "cellID"
    
    var collectionView:UICollectionView = {
        let layout = MNEmojiLayout()
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = UIColor.orange
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    
    var toolbar = MNEmojiToolbar()
    
    private var selectedEmojiCallBack:((_ emojiModel: MNEmojiModel?)->())?
    
    init(selectedEmoji:@escaping (_ emojiModel: MNEmojiModel?) -> ()) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: mnKeyboardHeight))
        selectedEmojiCallBack = selectedEmoji
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MNEmojiInputView{
    func setupUI() {
        toolbar.delegate = self
        toolbar.backgroundColor = UIColor.lightGray
        addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(kMNEmojiToolbarHeight)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MNEmojiCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(toolbar.snp.top)
        }
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toolbar.snp.top).offset(-8)
        }
        
        let bundle = MNEmojiManager.shared.bundle
        
        guard let normalImage = UIImage(named: "compose_keyboard_dot_normal", in: bundle, compatibleWith: nil),
        let selectedImage = UIImage(named: "compose_keyboard_dot_selected", in: bundle, compatibleWith: nil)
            else {
            return
        }
        pageControl.setValue(normalImage, forKey: "_pageImage")
        pageControl.setValue(selectedImage, forKey: "_currentPageImage")
    }
}

//MARK: - UICollectionViewDelegate
extension MNEmojiInputView: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //collectionView中心点
        var center = scrollView.center
        center.x += scrollView.contentOffset.x
        
        //当前中心点所在界面
        var targetIndex:IndexPath?
        
        let indexPaths = collectionView.indexPathsForVisibleItems
        
        for indexPath in indexPaths{
            let cell = collectionView.cellForItem(at: indexPath)
            
            if cell?.frame.contains(center) == true{
                targetIndex = indexPath
                break
            }
        }

        guard let target = targetIndex else {
            return
        }
        //indexPath.section = 组
        toolbar.selectedIndex = target.section
        
        pageControl.numberOfPages = collectionView.numberOfItems(inSection: target.section)
        pageControl.currentPage = target.item
    }
}

//MARK: - UICollectionViewDataSource
extension MNEmojiInputView:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MNEmojiManager.shared.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MNEmojiManager.shared.packages[section].numberOfPage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MNEmojiCell
        let package = MNEmojiManager.shared.packages[indexPath.section]
        cell.emojiModels = package.emojiModel(page: indexPath.item)
        cell.deleagage = self
        return cell
    }
}

extension MNEmojiInputView:MNEmojiCellDelegagte{
    func emojiCellSelectedEmoji(cell: MNEmojiCell, model: MNEmojiModel?) {
        //通过闭包回传选中的表情
        selectedEmojiCallBack?(model)
        
        //最近使用表情
        guard let model = model else {
            return
        }
        MNEmojiManager.shared.recentEmoji(model: model)
        
        //“最近使用”的不用添加表情逻辑
        let indexPath = collectionView.indexPathsForVisibleItems[0]
        if indexPath.section == 0{
            print("这是‘最近使用’的表情")
            return
        }
        
        //数据刷新
        var indexSet = IndexSet()
        indexSet.insert(0)
        collectionView.reloadSections(indexSet)
    }
}

extension MNEmojiInputView:MNEmojiToolBarDelegate{
    func emojiToolBarDidSelected(tooBar: MNEmojiToolbar, index: Int) {

        //滚动到每个分组的第[0]页
        let indexPath = IndexPath(item: 0, section: index)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        tooBar.selectedIndex = index
    }
}
