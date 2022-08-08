//
//  NavigationBar.swift
//  JobimFinal
//
//  Created by Arkadiy Akimov on 20/07/2022.
//

import UIKit

class NavigationBar : UINavigationBar {
    let utlt = Utility()
    let cnfg = Configuration()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .orange
        
        self = UINavigationBar(frame: CGRect(x: 0, y: cnfg.barHeight , width: UIScreen.main.bounds.width, height: cnfg.barHeight))
        self.backgroundColor = .clear
        self.isTranslucent = false
        self.barTintColor = cnfg.BrandOrange
        self.tintColor = cnfg.BrandWhite
        //self.delegate = sender

        navItem = UINavigationItem()
        navItem.title = cnfg.AppTitle
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: cnfg.NavBarMenuIcon), style: .plain, target: self, action: #selector(pushMenu))
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: cnfg.NavBarMapIcon), style: .plain, target: self, action: #selector(pushMapView))

        navBar.items = [navItem]

        view.addSubview(navBar)
        
    
}
