//
//  MNEmojiInputView.swift
//  MNWeibo
//
//  Created by miniLV on 2020/4/15.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit



class MNEmojiInputView: UIView {
    
    let cellID = "cellID"
    
    var keyboardHeight:CGFloat = 254.0
    
    var collectionView:UICollectionView = {
        let layout = MNEmojiLayout()
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    private var selectedEmojiCallBack:((_ emojiModel: MNEmojiModel?)->())?
    
    init(selectedEmoji:@escaping (_ emojiModel: MNEmojiModel?) -> ()) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: keyboardHeight))
        selectedEmojiCallBack = selectedEmoji
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MNEmojiInputView{
    func setupUI() {
        let toolbar = MNEmojiToolbar()
        toolbar.backgroundColor = UIColor.lightGray
        addSubview(toolbar)
        toolbar.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(kMNEmojiToolbarHeight)
        }
        
        collectionView.dataSource = self
        collectionView.register(MNEmojiCell.self, forCellWithReuseIdentifier: cellID)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(toolbar.snp.top)
        }
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
//        let cell = MNEmojiCell()
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
