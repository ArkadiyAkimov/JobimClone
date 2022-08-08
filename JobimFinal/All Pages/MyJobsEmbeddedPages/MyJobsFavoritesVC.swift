import UIKit

class MyJobsFavoritesVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource {
    
    var topCover : UIView!
    
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    var navBarActive: Bool = true
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UtilityService.cnfg.BrandWhite
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
        cell.backgroundColor = .cyan
        
        return cell
    }
    
    func configTableView () {
        //tableView.separatorStyle = .none
        //tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentMode = .center
        tableView.backgroundColor = .cyan
        
        self.view.addSubview(tableView)
        UtilityService.utlt.constrainWithinSpecificVoid(tableView, view.topAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
    }
}


