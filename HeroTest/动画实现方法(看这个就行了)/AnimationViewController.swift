//
//  AnimationViewController.swift
//  HeroTest
//
//  Created by FDM on 2019/10/17.
//  Copyright © 2019 发抖喵. All rights reserved.
//

//  所有的注释部分是与第一个页面的对比与提示！！！！！！！！1

import UIKit
import Hero
import SnapKit

//MARK: 分割线 ===================简单实例1=========================

class ViewController_1A: UIViewController {
    
    let blackView = UIView()
    let redView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        blackView.frame = CGRect(x: 70, y: 180, width: 300, height: 50)
        blackView.layer.cornerRadius = 15
        blackView.backgroundColor = .lightGray
        self.view.addSubview(blackView)
        
        redView.frame = CGRect(x: 90, y: 270, width: 260, height: 260)
        redView.layer.cornerRadius = 10
        redView.backgroundColor = .red
        self.view.addSubview(redView)
        
        /*-------------主要--------------*/
        blackView.hero.id = "blackView" //要与第二个页面相同的View的id名相同
        redView.hero.id = "redView"
        /*------------------------------*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController_1B()
        vc.hero.isEnabled = true      //出现动画的页面一定要打开这个
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// 实例1类分割线~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ViewController_1B: UIViewController {
    
    let blackView = UIView()
    let redView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        redView.frame = self.view.bounds    //修改红色的大小为全屏
//        redView.layer.cornerRadius = 10     去掉圆角(留着也可以)
        redView.backgroundColor = .red
        self.view.addSubview(redView)   //先添加红色的View，否则会把黑色的View盖住
        
        blackView.frame = CGRect(x: 70, y: 90, width: 300, height: 50) //将黑色的View向上移动
        blackView.layer.cornerRadius = 15
        blackView.backgroundColor = .lightGray
        self.view.addSubview(blackView)
        
        let whiteView = UIView()    //新添加一个白色的View
        whiteView.frame = CGRect(x: 70, y: 350, width: 300, height: 500)    //View的最终位置
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 15
        self.view.addSubview(whiteView)
        
        /*-------------主要--------------*/
        blackView.hero.id = "blackView"
        redView.hero.id = "redView"
        
        // translate(y:500) - 设置view是从y = 500的位置向y = 300的位置移动，useGlobalCoordinateSpace设置为独立的VIew(不设置的话效果差)
        whiteView.hero.modifiers = [.translate(y:500),.useGlobalCoordinateSpace]
        /*------------------------------*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.dismiss(animated: true, completion: nil)
     }
}

//MARK: 分割线 ===================简单实例2=========================

class ViewController_2A: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let blackView = UIView()
        blackView.frame = CGRect(x: 50, y: 120, width: 50, height: 50)
        blackView.layer.cornerRadius = 25
        blackView.backgroundColor = .lightGray
        self.view.addSubview(blackView)
        
        /*-------------主要--------------*/
        blackView.hero.id = "blackView"
        /*------------------------------*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController_2B()
        vc.hero.isEnabled = true //开启动画
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// 实例2类分割线~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ViewController_2B: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let blackView = UIView()
        blackView.frame = CGRect(x: 70, y: 180, width: 300, height: 50)     //修改了黑色View的位置与大小
        blackView.layer.cornerRadius = 15
        blackView.backgroundColor = .lightGray
        self.view.addSubview(blackView)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 90, y: 270, width: 260, height: 300), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        /*-------------主要--------------*/
        blackView.hero.id = "blackView"
        collectionView.hero.modifiers = [.cascade]      //层叠应用增加子视图的延迟修饰符(添加子视图动画时会有延迟加载)
        /*------------------------------*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.dismiss(animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 50
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .red
        
        /*-------------主要--------------*/
        cell.hero.modifiers = [.fade,.scale(0.5)]   //在添加cell时为其添加动画[.fade(淡入淡出的效果),.scale(0.5)放大倍数为0.5]
        /*------------------------------*/
        
        return cell
    }
}

//MARK: 分割线 ===================简单实例3=========================

class ViewController_3A: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        blueView.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: 200)
        view.addSubview(blueView)
        
        let scanView = UIImageView(image: UIImage(named: "card_scan"))
        scanView.frame = CGRect(x: 100, y: 30, width: 60, height: 60)
        blueView.addSubview(scanView)
        
        let codeView = UIImageView(image: UIImage(named: "card_code"))
        codeView.frame = CGRect(x: 200, y: 30, width: 60, height: 60)
        blueView.addSubview(codeView)
        
        blueView.hero.id = "blueView"
        scanView.hero.id = "barCode"
        codeView.hero.id = "qrCode"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = ViewController_3B()
        vc.hero.isEnabled = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// 实例3类分割线~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class ViewController_3B: UIViewController {
    
    let blueView = UIView()
    let whiteBGView = UIView()
    
    let cardTopView = UIView()
    let paymentBGView = UIView()
    let paymentLabel = UILabel()
    
    let cardBottomView = UIView()
    let cardImageView = UIImageView()
    let cardTitleLabel = UILabel()
    let cardSubTitleLabel = UILabel()
    
    let barCodeView = UIImageView()
    let barCodeLabel = UILabel()
    let qrCode = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 蓝色背景View
        view.addSubview(blueView)
        blueView.backgroundColor = .blue
        blueView.frame = view.bounds
        
        // 白色背景View
        blueView.addSubview(whiteBGView)
        whiteBGView.backgroundColor = .white
        whiteBGView.layer.cornerRadius = 5
        whiteBGView.clipsToBounds = true
        whiteBGView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().offset(-130)
        }
        
        // 顶部付款码提示View
        whiteBGView.addSubview(cardTopView)
        cardTopView.backgroundColor = .red
        cardTopView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(40)
        }
        
        // 付款码背景View
        whiteBGView.addSubview(paymentBGView)
        paymentBGView.backgroundColor = .red
        paymentBGView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(50)
        }
        
        // 付款码Label
        paymentBGView.addSubview(paymentLabel)
        paymentLabel.text = "付款码"
        paymentLabel.textColor = .white
        paymentLabel.textAlignment = .center
        paymentLabel.font = UIFont.systemFont(ofSize: 16)
        paymentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        // 底部一卡通提示View
        whiteBGView.addSubview(cardBottomView)
        cardBottomView.backgroundColor = .clear
        cardBottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(whiteBGView)
            make.height.equalTo(70)
        }
        
        // 底部一卡通提示图片
        cardBottomView.addSubview(cardImageView)
        cardImageView.image = UIImage(named: "ipass_card_logo")
        cardImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(60)
            make.height.equalTo(50)
        }
        
        // 底部一卡通标题
        cardBottomView.addSubview(cardTitleLabel)
        cardTitleLabel.text = "一卡通"
        cardTitleLabel.textAlignment = .center
        cardTitleLabel.font = UIFont.systemFont(ofSize: 14)
        cardTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cardImageView.snp.right).offset(20)
            make.top.equalTo(cardImageView.snp.top).offset(5)
        }
        
        // 底部一卡通副标题
        cardBottomView.addSubview(cardSubTitleLabel)
        cardSubTitleLabel.text = "方便快捷校园支付"
        cardSubTitleLabel.textColor = .lightGray
        cardSubTitleLabel.textAlignment = .center
        cardSubTitleLabel.font = UIFont.systemFont(ofSize: 12)
        cardSubTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cardTitleLabel)
            make.bottom.equalTo(cardImageView.snp.bottom).offset(-8)
        }
        
        // 条形码
        whiteBGView.addSubview(barCodeView)
        barCodeView.image = UIImage(named: "code1")
        barCodeView.backgroundColor = .lightGray
        barCodeView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(paymentBGView.snp.bottom).offset(30)
            make.height.equalTo(80)
        }
        
        // 付款编码提示
        whiteBGView.addSubview(barCodeLabel)
        barCodeLabel.text = " 付款编码"
        barCodeLabel.textColor = .lightGray
        barCodeLabel.textAlignment = .center
        barCodeLabel.font = UIFont.systemFont(ofSize: 12)
        barCodeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(barCodeView.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        // 二维码
        whiteBGView.addSubview(qrCode)
        qrCode.image = UIImage(named: "code2")
        qrCode.backgroundColor = .lightGray
        qrCode.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(barCodeLabel.snp.bottom).offset(15)
            make.bottom.equalTo(cardBottomView.snp.top).offset(-15)
            make.width.equalTo(qrCode.snp.height)
        }
        
        blueView.hero.id = "blueView"
        qrCode.hero.id = "qrCode"
        barCodeView.hero.id = "barCode"

        whiteBGView.hero.modifiers = [.fade,.translate(y:-800),.useGlobalCoordinateSpace]
        cardBottomView.hero.modifiers = [.translate(x:-500),.useGlobalCoordinateSpace]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.dismiss(animated: true, completion: nil)
    }
}
