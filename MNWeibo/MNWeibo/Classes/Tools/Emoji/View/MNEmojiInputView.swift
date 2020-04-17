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
        
        let layout = MNEmojiLayout()
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(MNEmojiCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.white
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
    }
}
