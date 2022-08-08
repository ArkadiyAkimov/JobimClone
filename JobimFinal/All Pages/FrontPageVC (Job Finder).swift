import UIKit

class FrontPageVC: CustomViewController, UINavigationBarDelegate {
    
    let jobBrowserView = JobBrowserVC()
    let mapView = MapVC()
    var filterView = FilterVC()
    
    var topCover : UIView!
    var coverView = UIView()
    
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    var navBarActive: Bool = true
    
    var filterBar = UIView()
    var filterButton = UIButton()
    var filterButton2 = UIButton()
    var filterTopCover = UIView()
    
    
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UtilityService.cnfg.BrandWhite
    configTopCover()
    configNavBar()
    configFilterBar()
    
    filterView.mainNavBar = navBar
    
    addChild(filterView)
    addChild(mapView)
    addChild(jobBrowserView)
    
    configCustomTriangleView()
    
    mapView.JobBrowser = jobBrowserView
    addMapVC()
    addJobBrowserVC()
    configFilterTopCover()
    addFilterVC()
}
    
    func configCustomTriangleView(){
        customTrianlgeView = CustomTriangleView(frame: CGRect(x: -1 , y: view.bounds.height , width: view.bounds.width * 0.15 , height: view.bounds.height))
        view.addSubview(customTrianlgeView)
        customTrianlgeView.backgroundColor = UtilityService.cnfg.BrandWhite
    }
    
    func configFilterTopCover(){

        filterTopCover = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UtilityService.cnfg.barHeight * 2))
        view.addSubview(filterTopCover)
        filterTopCover.backgroundColor = .black
        filterTopCover.alpha = 0
        //view.bringSubviewToFront(safeAreaCover)
    }
    
    func configTopCover(){
        
        topCover = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width , height: UtilityService.cnfg.barHeight))
        view.addSubview(topCover)
        topCover.backgroundColor = UtilityService.cnfg.BrandOrange
    }
    
    func configNavBar(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UtilityService.cnfg.barHeight , width: UIScreen.main.bounds.width, height: UtilityService.cnfg.barHeight))
        navBar.backgroundColor = .clear
        navBar.isTranslucent = false
        navBar.barTintColor = UtilityService.cnfg.BrandOrange
        navBar.tintColor = UtilityService.cnfg.BrandWhite
        navBar.delegate = self

        navItem = UINavigationItem()
        navItem.title = UtilityService.cnfg.AppTitle
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMenuIcon), style: .plain, target: self, action: #selector(pushMenu))
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMapIcon), style: .plain, target: self, action: #selector(pushMapView))

        navBar.items = [navItem]

        view.addSubview(navBar)
        //navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        //self.view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
    }
    
    private func configFilterBar () {
        filterBar = UIView(frame: CGRect(x: 0, y: UtilityService.cnfg.barHeight * 2, width: view.bounds.width, height: UtilityService.cnfg.barHeight))
        view.addSubview(filterBar)
        filterBar.backgroundColor = UtilityService.cnfg.BrandWhite
        addFilterBarFunctionality()
    }
    
    private func addFilterBarFunctionality () {
        secondButtonForAnimation()
        filterBar.addSubview(filterButton)
        UtilityService.utlt.constrainEquallyWithinVoid(filterBar, filterButton, 10, false)
        filterButton.backgroundColor = UtilityService.cnfg.BrandWhite
        filterButton.setTitle(UtilityService.cnfg.FilterButtonText, for: .normal)
        filterButton.setTitleColor(UtilityService.cnfg.BrandOrange, for: .normal)
        filterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        filterButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        filterButton.titleLabel?.contentMode = .center
        filterButton.tintColor = UtilityService.cnfg.BrandOrange
        filterButton.setImage(UIImage(systemName: UtilityService.cnfg.FilterButtonIcon), for: .normal)
        filterButton.layer.borderColor = UtilityService.cnfg.BrandOrange.cgColor
        filterButton.layer.borderWidth = 1
        filterButton.addTarget(self, action: #selector(pushFilterView), for: .touchUpInside)
        filterButton.transform = CGAffineTransform(scaleX: 1, y: 1.15)
    }
    
    private func secondButtonForAnimation () {
        filterBar.addSubview(filterButton2)
        UtilityService.utlt.constrainEquallyWithinVoid(filterBar, filterButton2, 10, false)
        filterButton2.backgroundColor = UtilityService.cnfg.BrandOrange
        filterButton2.setTitle(UtilityService.cnfg.FilterButtonText, for: .normal)
        filterButton2.setTitleColor(UtilityService.cnfg.BrandWhite, for: .normal)
        filterButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        filterButton2.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        filterButton2.tintColor = UtilityService.cnfg.BrandWhite
        filterButton2.setImage(UIImage(systemName: UtilityService.cnfg.FilterButtonIcon), for: .normal)
        filterButton2.layer.borderColor = UtilityService.cnfg.BrandWhite.cgColor
        filterButton2.layer.borderWidth = 1
        filterButton2.addTarget(self, action: #selector(pushFilterView), for: .touchUpInside)
        filterButton2.transform = CGAffineTransform(scaleX: 1, y: 1.1)
    }
    
    @objc private func pushFilterView () {
        navBarActive = false
        //addFilterVC()
        view.bringSubviewToFront(filterView.view)
        view.bringSubviewToFront(topCover)
        view.bringSubviewToFront(navBar)
        view.bringSubviewToFront(filterTopCover)
        self.filterButton.alpha = 0
        UIWindow.animate(withDuration: 0.4, delay: 0) {
            self.filterButton.alpha = 1
            self.filterBar.alpha = 0
            self.filterTopCover.alpha = 0.3
            
        }
        filterView.loadAnimation(self)
    }
    
    func pullFilterView () {
        navBarActive = true
        UIWindow.animate(withDuration: 0.2, delay: 0) {
            self.filterBar.alpha = 1
            self.filterTopCover.alpha = 0
        }
    }
    
    private func addFilterVC () {
        view.addSubview(filterView.view)
        filterView.didMove(toParent: self)
        UtilityService.utlt.constrainWithinSpecificVoid( filterView.view , filterBar.topAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        filterView.view.alpha = 0
    }
    
    private func addJobBrowserVC () {
        view.addSubview(jobBrowserView.view)
        jobBrowserView.didMove(toParent: self)
        UtilityService.utlt.constrainWithinSpecificVoid( jobBrowserView.view , filterBar.bottomAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
    }
    
    private func addMapVC () {
        view.addSubview(mapView.view)
        mapView.didMove(toParent: self)
        UtilityService.utlt.constrainWithinSpecificVoid( mapView.view , filterBar.bottomAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
    }
    
    @objc private func pushMapView () {
        if navBarActive{
            mapView.trackSelf()
        jobBrowserView.dismissAnimation()
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarJobBrowserIcon), style: .plain , target: self, action: #selector(pushJobBrowserView))
        }
    }
    
    @objc private func pushJobBrowserView () {
        if navBarActive{
        addJobBrowserVC()
        jobBrowserView.loadAnimation()
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMapIcon ), style: .plain , target: self, action: #selector(pushMapView))
        }
    }

}
