import UIKit

class MyJobsVC: CustomViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource {
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()

    let myJobsAppliedToPage = MyJobsAppliedToVC()
    let myJobsFavoritesPage = MyJobsFavoritesVC()
    
    let segmentedControl = UISegmentedControl(items: ["פניתי ל...","מועדפים"])
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UtilityService.cnfg.BrandWhite
    configTopCover()
    configNavBar()
    configSegmentedControl()
    segmentedControl.selectedSegmentIndex = 1
    
    addChild(myJobsAppliedToPage)
    addChild(myJobsFavoritesPage)
    
    
    customTrianlgeView = CustomTriangleView(frame: CGRect(x: -1 , y: view.bounds.height , width: view.bounds.width * 0.15 , height: view.bounds.height))
    view.addSubview(customTrianlgeView)
    customTrianlgeView.backgroundColor = .white
    
    configSegmentedViews()
    segmentedControl.addTarget(self, action: #selector(segmentedControlChange), for: .valueChanged)
}
    
    @objc func segmentedControlChange (sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            myJobsFavoritesPage.view.alpha = 1
            myJobsFavoritesPage.view.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
            UIWindow.animate(withDuration: 0.3, delay: 0) {
                self.myJobsAppliedToPage.view.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                self.myJobsFavoritesPage.view.transform = CGAffineTransform.identity
            } completion: { Bool in
                self.myJobsAppliedToPage.view.alpha = 0
            }
            break
        case 0:
            self.myJobsAppliedToPage.view.alpha = 1
            myJobsAppliedToPage.view.transform = CGAffineTransform(translationX: -view.frame.width, y: 0)
            UIWindow.animate(withDuration: 0.3, delay: 0) {
                self.myJobsFavoritesPage.view.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                self.myJobsAppliedToPage.view.transform = CGAffineTransform.identity
            } completion: { Bool in
                self.myJobsFavoritesPage.view.alpha = 0
            }
            break
        default:
            break
        }
    }
    
    func configSegmentedControl () {
        view.addSubview(segmentedControl)
        segmentedControl.frame = CGRect(x: 10
        , y: UtilityService.cnfg.barHeight * 2 + 10 , width: view.bounds.width - 20 ,
        height: navBar.bounds.height - 10 )
        //segmentedControl.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        segmentedControl.setTitleTextAttributes( [.foregroundColor: UtilityService.cnfg.BrandOrange , .font: UIFont.systemFont(ofSize: 20)], for: .normal)
        segmentedControl.selectedSegmentTintColor = UtilityService.cnfg.BrandOrange
        segmentedControl.tintColor = UtilityService.cnfg.BrandOrange
        
        segmentedControl.setTitleTextAttributes( [.foregroundColor: UtilityService.cnfg.BrandWhite ], for: .selected)
        segmentedControl.layer.borderColor = UtilityService.cnfg.BrandOrange.cgColor
        segmentedControl.layer.borderWidth = 2
        segmentedControl.layer.backgroundColor = UtilityService.cnfg.BrandWhite.cgColor
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //cell.selectionStyle = .none
        
        return cell
    }
    
    func configSegmentedViews () {
        
        self.view.addSubview(myJobsAppliedToPage.view)
        UtilityService.utlt.constrainWithinSpecificVoid(myJobsAppliedToPage.view, segmentedControl.bottomAnchor, 10, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
        self.view.addSubview(myJobsFavoritesPage.view)
        UtilityService.utlt.constrainWithinSpecificVoid(myJobsFavoritesPage.view, segmentedControl.bottomAnchor, 10, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
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

        navBar.items = [navItem]

        view.addSubview(navBar)
    }
}

