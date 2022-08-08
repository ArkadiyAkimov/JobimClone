
import UIKit

class AboutVC: CustomViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource {
    let jobBrowserView = JobBrowserVC()
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    
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
    
    addChild(jobBrowserView)
    
    
    customTrianlgeView = CustomTriangleView(frame: CGRect(x: -1 , y: view.bounds.height , width: view.bounds.width * 0.15 , height: view.bounds.height))
    view.addSubview(customTrianlgeView)
    customTrianlgeView.backgroundColor = .white
    
    
    configTableView()
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
    
    func configTableView () {
        //tableView.separatorStyle = .none
        //tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentMode = .center
        tableView.backgroundColor = UtilityService.cnfg.BrandWhite
        
        self.view.addSubview(tableView)
        UtilityService.utlt.constrainWithinSpecificVoid(tableView, navBar.bottomAnchor, 10, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
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
        navItem.title = "קצת עלינו"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMenuIcon), style: .plain, target: self, action: #selector(pushMenu))

        navBar.items = [navItem]

        view.addSubview(navBar)
    }
    
    
    private func addJobBrowserVC () {
        view.addSubview(jobBrowserView.view)
        jobBrowserView.didMove(toParent: self)
        UtilityService.utlt.constrainWithinSpecificVoid( jobBrowserView.view , navBar.bottomAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
    }
    
    
    @objc private func pushJobBrowserView () {
        addJobBrowserVC()
        jobBrowserView.loadAnimation()
        navItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMapIcon ), style: .plain , target: self, action: nil )
    }

    
}

