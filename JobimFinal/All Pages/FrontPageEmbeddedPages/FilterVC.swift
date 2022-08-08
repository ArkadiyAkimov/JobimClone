import UIKit

class FilterVC : SimpleViewController {
    
    public var mainNavBar = UINavigationBar()
    var navBar = UIStackView()
    
    let innerView = UIView()
    var reference : FrontPageVC!
    let segmentedControl = UISegmentedControl(items: ["חברה","מיקום","ג׳וב"])
    let rightNavBtn = UIButton()
    
    let filterByCompanyPage = FilterByCompanyVC()
    let filterByLocationPage = FilterByLocationVC()
    let filterByJobTypePage = FilterByJobTypeVC()
    
    var currPage: SimpleViewController!
    var currPageIndex : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UtilityService.cnfg.BrandWhite
        view.addSubview(innerView)
        UtilityService.utlt.constrainEquallyWithinVoid(view, innerView, 0, false)
        innerView.backgroundColor = UtilityService.cnfg.BrandWhite
        
        configNavBar()
        configSegmentedControl()
        
        addChild(filterByCompanyPage)
        addChild(filterByLocationPage)
        addChild(filterByJobTypePage)
        
        
        configSegmentedViews(filterByCompanyPage)
        configSegmentedViews(filterByLocationPage)
        configSegmentedViews(filterByJobTypePage)
        
        currPageIndex = 2
        segmentedControl.selectedSegmentIndex = currPageIndex
        currPage = filterByJobTypePage
        currPage.view.alpha = 1
        
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChange), for: .valueChanged)
        
    }
    
    func configSegmentedViews (_ page: SimpleViewController) {
        self.view.addSubview(page.view)
        
        UtilityService.utlt.constrainWithinSpecificVoid(page.view, segmentedControl.bottomAnchor, 10 , view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        page.view.alpha = 0
        
    }
    
    @objc func nextSegmentedIndex () {
        if currPageIndex < 4 {
        segmentedControl.selectedSegmentIndex = currPageIndex + 1
        segmentedControlChange(sender: segmentedControl)
        }
    }
    
    func transitionAnimation(_ fromPage:UIViewController ,_ toPage:UIViewController,_ toPageIndex:Int) {
        var toPageDirectionMult = CGFloat()
        var fromPageDirectionMult = CGFloat()
        
        if toPageIndex > currPageIndex {
        toPageDirectionMult = 1
        fromPageDirectionMult = -1
        } else {
        toPageDirectionMult = -1
        fromPageDirectionMult = 1
        }
        
        toPage.view.alpha = 1
        toPage.view.transform = CGAffineTransform(translationX: toPageDirectionMult * view.frame.width, y: 0)
        UIWindow.animate(withDuration: 0.3, delay: 0) {
            fromPage.view.transform = CGAffineTransform(translationX: fromPageDirectionMult * self.view.frame.width, y: 0)
            toPage.view.transform = CGAffineTransform.identity
        } completion: { Bool in
            fromPage.view.alpha = 0
        }
    }
    
    @objc func segmentedControlChange (sender: UISegmentedControl) {
        dismissKeyboard()
        switch sender.selectedSegmentIndex {
        case 2:
            transitionAnimation(currPage, filterByJobTypePage, 2)
            currPage = filterByJobTypePage
            currPageIndex = 2
            break
        case 1:
            transitionAnimation(currPage, filterByLocationPage, 1)
            currPage = filterByLocationPage
            currPageIndex = 1
            break
        case 0:
            transitionAnimation(currPage, filterByCompanyPage, 0)
            currPage = filterByCompanyPage
            currPageIndex = 0
            break
        default:
            break
        }
    }
    
    @objc func dismissSelf () {
        exitAnimation()
        reference.pullFilterView()
    }
    
    @objc func saveChoice () {
        AppDataService.filterRepository.mainProcess()
        dismissSelf()
    }
    
    func loadAnimation (_ sender: FrontPageVC) {
        reference = sender
        self.view.alpha = 1
        self.navBar.transform = CGAffineTransform(translationX: 0, y: -UtilityService.cnfg.barHeight)
        self.segmentedControl.transform = CGAffineTransform(translationX: 0, y: -UtilityService.cnfg.barHeight)
        self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
        UIView.animate(withDuration: 0.3, delay: 0.2) {
            self.view.transform = CGAffineTransform.identity
            
        }
        UIWindow.animate(withDuration: 0.4, delay: 0.2) {
            self.navBar.transform = CGAffineTransform.identity
            self.segmentedControl.transform = CGAffineTransform.identity
        }
    }
    
    func exitAnimation () {
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
        } completion: { Bool in
            self.view.alpha = 0
            //self.view.removeFromSuperview()
        }
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.navBar.transform = CGAffineTransform(translationX: 0, y: -UtilityService.cnfg.barHeight)
            self.segmentedControl.transform = CGAffineTransform(translationX: 0, y: -UtilityService.cnfg.barHeight)
        }
    }
    
    func configNavBar () {
        navBar = UIStackView()
        innerView.addSubview(navBar)
        navBar.backgroundColor = UtilityService.cnfg.BrandWhite
        navBar.frame = CGRect(x: 0, y: 0, width: view.frame.width ,
        height: mainNavBar.bounds.height )
        
        let leftNavBtn = UIButton()
        leftNavBtn.frame = CGRect(
            x: navBar.bounds.width - navBar.bounds.height * 1.5 ,
        y: 0,
            width: navBar.bounds.height * 1.5 ,
        height: navBar.bounds.height )
        //leftNavBtn.setImage(UIImage(systemName: "person"), for: .normal)
        leftNavBtn.setTitle("אשר", for: .normal)
        leftNavBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //leftNavBtn.tintColor = .orange
        leftNavBtn.setTitleColor(UtilityService.cnfg.BrandOrange, for: .normal)
        leftNavBtn.backgroundColor = UtilityService.cnfg.BrandWhite
        navBar.addSubview(leftNavBtn)
        leftNavBtn.addTarget(self, action: #selector(saveChoice), for: .touchUpInside)
        
        
        rightNavBtn.frame = CGRect(
            x: 0 , y: 0,
            width: navBar.bounds.height * 1.5 ,
        height: navBar.bounds.height )
        //rightNavBtn.setImage(UIImage(systemName: "person"), for: .normal)
        rightNavBtn.setTitle("בטל", for:  .normal)
        rightNavBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        //rightNavBtn.tintColor = .orange
        rightNavBtn.setTitleColor(.orange, for: .normal)
        rightNavBtn.backgroundColor = .white
        navBar.addSubview(rightNavBtn)
        rightNavBtn.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        
        let navTitle = UILabel()
        navTitle.frame = CGRect(
        x: navBar.bounds.height * 1.5  , y: 0,
        width: navBar.bounds.width -
        (navBar.bounds.height * 1.5) * 2 ,
        height: navBar.bounds.height )
        //rightNavBtn.setImage(UIImage(systemName: "person"), for: .normal)
        navTitle.text = "הצג לפי"
        navTitle.font = UIFont.systemFont(ofSize: 20)
        navTitle.textAlignment = .center
        navTitle.textColor = UtilityService.cnfg.BrandOrange
        //rightNavBtn.tintColor = .orange
        navTitle.backgroundColor = UtilityService.cnfg.BrandWhite
        navBar.addSubview(navTitle)
        
    }
    
    func configSegmentedControl () {
        innerView.addSubview(segmentedControl)
        segmentedControl.frame = CGRect(x: 10
        , y: UtilityService.cnfg.barHeight , width: view.bounds.width - 20 ,
        height: mainNavBar.bounds.height - 10 )
        //segmentedControl.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        segmentedControl.setTitleTextAttributes( [.foregroundColor: UtilityService.cnfg.BrandOrange , .font: UIFont.systemFont(ofSize: 20)], for: .normal)
        segmentedControl.selectedSegmentTintColor = UtilityService.cnfg.BrandOrange
        segmentedControl.tintColor = UtilityService.cnfg.BrandOrange
        
        segmentedControl.setTitleTextAttributes( [.foregroundColor: UtilityService.cnfg.BrandWhite ], for: .selected)
        segmentedControl.layer.borderColor = UtilityService.cnfg.BrandOrange.cgColor
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.backgroundColor = UtilityService.cnfg.BrandWhite.cgColor
    }
}

