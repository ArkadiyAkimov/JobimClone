import UIKit

class SettingsVC: SimpleViewController ,UITableViewDelegate, UITableViewDataSource {
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    
    var filterTopCover = UIView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    configTopCover()
    configNavBar()
    configTableView()
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UtilityService.cnfg.barHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        
        let label = UILabel(frame: CGRect(x: 20, y: -10 , width: cell.frame.width - 40, height: cell.frame.height))
        label.text = "נוטיפיקציות ועדכונים"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.contentMode = .center
        label.textAlignment = .right
        
        let updatesSwitch = UISwitch(frame: CGRect(x: 20, y: 0, width: cell.frame.height, height: cell.frame.height))
        updatesSwitch.onTintColor = UtilityService.cnfg.BrandOrange
        updatesSwitch.isOn = AppDataService.userRepository.isNotificationsAndUpdatesOn
        updatesSwitch.addTarget(self, action: #selector(switchUpdates(_:)), for: .valueChanged)
        
        cell.addSubview(label)
        cell.addSubview(updatesSwitch)
        return cell
    }
    
    @objc func switchUpdates (_ sender:UISwitch) {
        AppDataService.userRepository.isNotificationsAndUpdatesOn = sender.isOn
    }
    
    func configTableView () {
        //tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentMode = .center
        tableView.backgroundColor = UtilityService.cnfg.BrandWhite
        
        self.view.addSubview(tableView)
        UtilityService.utlt.constrainWithinSpecificVoid(tableView, navBar.bottomAnchor, 20, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
    }
    
    func configFilterTopCover(){
        filterTopCover = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UtilityService.cnfg.barHeight * 2))
        view.addSubview(filterTopCover)
        filterTopCover.backgroundColor = .black
        filterTopCover.alpha = 0
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

        navItem = UINavigationItem()
        navItem.title = "הגדרות"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBackIcon ), style: .plain, target: self, action: #selector(dismissSelfFully))

        navBar.items = [navItem]
        view.addSubview(navBar)
    }
}

