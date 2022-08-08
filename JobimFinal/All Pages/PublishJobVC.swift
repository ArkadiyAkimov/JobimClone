import UIKit

class PublishJobVC: CustomViewController, UINavigationBarDelegate, jobDataDelegate {
    func onJobDataUpdated(_ jobData: JobData) {
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
    }
    
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    var navBarActive: Bool = true
    
    let publishJobCompanyNamePage = PublishJobCompanyNameVC()
    let publishJobTypeOfJobPage = PublishJobTypeOfJobVC()
    let publishJobDescriptionPage = PublishJobDescriptionVC()
    let publishJobLocationPage = PublishJobLocationVC()
    let publishJobImageEtcPage = PublishJobImageEtcVC()
    let publishContactsPage = PublishContactsVC()
    
    var currentPageSelected: SimpleViewController!
    var currentPageSelectedIndex : Int!
    
    var segmentedCovers = [UIView]()
    
    let segmentedControl = UISegmentedControl(items:[UIImage(systemName: "person.text.rectangle")!,UIImage(systemName: "briefcase")!,
                  UIImage(systemName: "doc.plaintext")!,UIImage(systemName: "mappin.and.ellipse")!,UIImage(systemName: "paperclip")!])
    
override func viewDidLoad() {
    super.viewDidLoad()
    AppDataService.jobRepository.subscribe(self)
    view.backgroundColor = UtilityService.cnfg.BrandWhite
    configTopCover()
    configNavBar()
    configSegmentedControl()
    
    
    
    addChild(publishJobCompanyNamePage)
    addChild(publishJobTypeOfJobPage)
    addChild(publishJobDescriptionPage)
    addChild(publishJobLocationPage)
    addChild(publishJobImageEtcPage)
    
    configCustomTriangleView()
    configSegmentedViews(publishJobCompanyNamePage)
    configSegmentedViews(publishJobTypeOfJobPage)
    configSegmentedViews(publishJobDescriptionPage)
    configSegmentedViews(publishJobLocationPage)
    configSegmentedViews(publishJobImageEtcPage)
    
    configPageView(publishContactsPage, true)
    
    publishContactsPage.PublishJobPage = self
    publishJobTypeOfJobPage.publishJobPage = self
    
    initializeSelectedSegment()
    
    segmentedControl.addTarget(self, action: #selector(segmentedControlDirectInteraction(sender:)), for: .valueChanged)
    
    
}
    func initializeSelectedSegment(){
        currentPageSelectedIndex = 0
        segmentedControl.selectedSegmentIndex = currentPageSelectedIndex
        currentPageSelected = publishJobCompanyNamePage
        currentPageSelected.view.alpha = 1
    }
    
    func configCustomTriangleView (){
        customTrianlgeView = CustomTriangleView(frame: CGRect(x: -1 , y: view.bounds.height , width: view.bounds.width * 0.15 , height: view.bounds.height ))
        view.addSubview(customTrianlgeView)
        customTrianlgeView.backgroundColor = .white
    }
    
    @objc func publishNewJob() {
        segmentedControl.setImage(UIImage(systemName: "checkmark"), forSegmentAt: currentPageSelectedIndex)
        AppDataService.jobRepository.updateUnpublishedJobData()
        
        pushPageView(publishContactsPage)
    }
    
    func transitionAnimation(_ fromPage:UIViewController ,_ toPage:UIViewController,_ toPageIndex:Int) {
        var toPageDirectionMult = CGFloat()
        var fromPageDirectionMult = CGFloat()
        
        if toPageIndex > currentPageSelectedIndex {
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
    
    @objc func segmentedControlDirectInteraction (sender: UISegmentedControl){
        if segmentedControl.imageForSegment(at: sender.selectedSegmentIndex) == UIImage(systemName: "checkmark") ||
            segmentedControl.imageForSegment(at: sender.selectedSegmentIndex - 1) == UIImage(systemName: "checkmark"){
            segmentedControlChange(sender: sender)
        } else {
            segmentedControl.selectedSegmentIndex = currentPageSelectedIndex
        }
    }
    
    @objc func segmentedControlChange (sender: UISegmentedControl) {
        
        dismissKeyboard()
        AppDataService.jobRepository.updateUnpublishedJobData()
        switch sender.selectedSegmentIndex {
        case 4:
            transitionAnimation(currentPageSelected, publishJobImageEtcPage, 4)
            currentPageSelected = publishJobImageEtcPage
            currentPageSelectedIndex = 4
            break
        case 3:
            transitionAnimation(currentPageSelected, publishJobLocationPage, 3)
            currentPageSelected = publishJobLocationPage
            currentPageSelectedIndex = 3
            break
        case 2:
            transitionAnimation(currentPageSelected, publishJobDescriptionPage, 2)
            currentPageSelected = publishJobDescriptionPage
            currentPageSelectedIndex = 2
            break
        case 1:
            transitionAnimation(currentPageSelected, publishJobTypeOfJobPage, 1)
            currentPageSelected = publishJobTypeOfJobPage
            currentPageSelectedIndex = 1
            break
        case 0:
            transitionAnimation(currentPageSelected, publishJobCompanyNamePage, 0)
            currentPageSelected = publishJobCompanyNamePage
            currentPageSelectedIndex = 0
            break
        default:
            break
        }
        
        if currentPageSelectedIndex == 4 {
            navItem.rightBarButtonItem = UIBarButtonItem(title: "הבא", style: .plain , target: self, action: #selector(publishNewJob))
        } else {
            navItem.rightBarButtonItem = UIBarButtonItem(title: "הבא", style: .plain , target: self, action: #selector(nextSegmentedIndex))
        }
    }
    
    func configSegmentedControl () {
        view.addSubview(segmentedControl)
        segmentedControl.frame = CGRect(x: 0 , y: UtilityService.cnfg.barHeight * 2 , width: view.bounds.width , height: UtilityService.cnfg.barHeight * 1.3 )
        //segmentedControl.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        segmentedControl.setTitleTextAttributes( [.foregroundColor: UtilityService.cnfg.BrandWhite , .font: UIFont.systemFont(ofSize: 20)], for: .normal)
        segmentedControl.selectedSegmentTintColor = UtilityService.cnfg.BrandOrange
        segmentedControl.tintColor = UtilityService.cnfg.BrandOrange
        
        segmentedControl.setTitleTextAttributes( [.foregroundColor: UtilityService.cnfg.BrandWhite ], for: .selected)
        segmentedControl.layer.borderColor = UtilityService.cnfg.BrandWhite.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.backgroundColor =
        UtilityService.cnfg.BrandOrange.cgColor
        segmentedControl.selectedSegmentTintColor = UtilityService.cnfg.BrandOrange
        
        
        let tintView = UIStackView(frame: segmentedControl.bounds)
        segmentedControl.addSubview(tintView)
        tintView.backgroundColor = .clear
        tintView.distribution = .fillEqually
        for i in 0...4{
        segmentedCovers.append(UIView())
        segmentedCovers[i].backgroundColor = .white
        segmentedCovers[i].alpha = 0.5
        tintView.addArrangedSubview(segmentedCovers[i])
        }
        segmentedCovers[0].alpha = 0
    }
    
    func dimSegmentCovers(){
        for i in 1...4 {
            segmentedCovers[i].alpha = 0.5
        }
    }
    
    func configSegmentedViews (_ page: SimpleViewController) {
        self.view.addSubview(page.view)
        UtilityService.utlt.constrainWithinSpecificVoid(page.view, segmentedControl.bottomAnchor, 0 , view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        page.view.alpha = 0
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
        navItem.title = "הג׳ובים שלי"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMenuIcon), style: .plain, target: self, action: #selector(pushMenu))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "הבא", style: .plain , target: self, action: #selector(nextSegmentedIndex))
        navBar.items = [navItem]
        view.addSubview(navBar)
    }
    
    @objc func nextSegmentedIndex () {
        segmentedControl.setImage(UIImage(systemName: "checkmark"), forSegmentAt: currentPageSelectedIndex)
        segmentedCovers[currentPageSelectedIndex+1].alpha = 0
        if currentPageSelectedIndex < 4 {
        segmentedControl.selectedSegmentIndex = currentPageSelectedIndex + 1
        segmentedControlChange(sender: segmentedControl)
        }
        
    }
    
    func reloadOriginalSegmentIcons () {
        segmentedControl.setImage(UIImage(systemName: "paperclip"), forSegmentAt: 4)
        segmentedControl.setImage(UIImage(systemName: "mappin.and.ellipse"), forSegmentAt: 3)
        segmentedControl.setImage(UIImage(systemName: "doc.plaintext"), forSegmentAt: 2)
        segmentedControl.setImage(UIImage(systemName: "briefcase"), forSegmentAt: 1)
        segmentedControl.setImage(UIImage(systemName: "person.text.rectangle"), forSegmentAt: 0)
        
    }
    
    func configPageView(_ page: SimpleViewController,_ dismiss:Bool){
        addChild(page)
        page.didMove(toParent: self)
        view.addSubview(page.view)
        UtilityService.utlt.constrainEquallyWithinVoid(view, page.view, 0, false)
        if dismiss {
        page.dismissSelfFully()
        }
    }
    
    @objc func pushPageView (_ pageView: SimpleViewController) {
        view.bringSubviewToFront(pageView.view)
        AppDataService.userRepository.updateData()
        UIView.animate(withDuration: 0.3, delay: 0) {
            pageView.view.transform = CGAffineTransform.identity
        }
    }
}

