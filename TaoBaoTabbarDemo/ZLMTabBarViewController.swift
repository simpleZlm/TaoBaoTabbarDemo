//
//  ZLMTabBarViewController.swift
//  TaoBaoTabbarDemo
//
//  Created by 赵黎明 on 2017/3/13.
//  Copyright © 2017年 赵黎明. All rights reserved.
//

import UIKit
import AudioToolbox
class ZLMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildViewController(ZLMHomeViewController(), title: "首页", imageName: "tab1")
        
        addChildViewController(ZLMCategoryViewController(), title: "分类", imageName: "tab2")
        
        addChildViewController(ZLMSaleViewController(), title: "促销", imageName: "tab3")
        
        addChildViewController(ZLMShoppingCartViewController(), title: "购物车", imageName: "tab4")
        
        addChildViewController(ZLMMineViewController(), title: "我的", imageName: "tab5")
        
        
        
        
    }
    private func addChildViewController(_ childController: UIViewController,title:String,imageName:String) {
        
        childController.title = title
        
        childController.tabBarItem.image = UIImage(named:imageName)
        
        childController.tabBarItem.selectedImage = UIImage(named:imageName + "_p")
        
        let childNav = UINavigationController(rootViewController:childController)
        
        addChildViewController(childNav)
        
        //设置选中和未选中字体颜色
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName:UIColor.red], for:.selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var index:NSInteger?
        index = self.tabBar.items?.index(of: item)
        playSound()//音效
        animationWithIndex(index!)//动画
    }
    
    
    func playSound(){
         let path = Bundle.main.path(forResource: "like", ofType: "caf")
         let soundURL = NSURL.fileURL(withPath: path!)
         var soundID = SystemSoundID()
        
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
        
        
    }
    func animationWithIndex(_ index :NSInteger){
        
        var tabbarbuttonArray : Array<UIView?> = []
        for tabBarButton in (self.tabBar.subviews) {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!){
                 tabbarbuttonArray.append(tabBarButton)
            }
        }
        let pulse = CABasicAnimation.init(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.duration = 0.08;
        pulse.repeatCount = 1;
        pulse.autoreverses = true;
        pulse.fromValue = NSNumber.init(value: 0.7)
        pulse.toValue = NSNumber.init(value: 1.3)
        tabbarbuttonArray[index]?.layer.add(pulse,forKey:nil)
    }

}
