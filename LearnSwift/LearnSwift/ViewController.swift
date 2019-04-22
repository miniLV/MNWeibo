//
//  ViewController.swift
//  LearnSwift
//
//  Created by Tyrion Liang on 2019/4/22.
//  Copyright © 2019 Tyrion Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        demo1()
//        demo2()
//        demo3()
    }
    
    //TODO: - switch
    func demo3() {
        
        let tag = 10
        switch tag {
        case 5,10 :
            print("<5")
        default:
            print(">5")
        }
        
        
    }
    
    //TODO: - setupUI
    func demo2() -> () {
        
        //setup redView
        let v = UIView.init(frame: CGRect.init(x: 20, y: 100, width: 200, height: 40))
        view .addSubview(v)
        v.backgroundColor = UIColor.red
        
        //setup button
        let btn = UIButton.init(type: .contactAdd)
        btn .backgroundColor = UIColor.orange
        v .addSubview(btn)
        //TODO: center异常操作？
        //btn.center = v.center
        btn .addTarget(self, action: #selector(touch), for: .touchUpInside)

    }
    
    @objc func touch() -> () {
        print("touch!!")
    }
    
    //TODO: - base
    func demo1() {

//        let a: Double = 10
//        let b = 10.5
//        print(a + b)

//        let str1 = "haha"
//        let str2 = "20"
//        let res = str1 + str2
//        print(res)

        let list1 = ["aa","bb","cc"]
        let list2 = ["1"]
        let res = list1 + list2
        print(res)
        
        for i in 0..<res.count {
            print(res[i])
        }
        
        for i in 0...10 {
            print(i)
        }
        
        print("---")
        
        for i in 0..<10 {
            print(i)
        }
        
    }

}

