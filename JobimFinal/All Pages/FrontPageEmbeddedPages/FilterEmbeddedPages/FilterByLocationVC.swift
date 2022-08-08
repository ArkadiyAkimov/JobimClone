import UIKit

class FilterByLocationVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource {
    
    var searchBar : UIView!
    var textField : UISearchTextField!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UtilityService.cnfg.BrandWhite
    
    configSearchBar()
    configTableView()
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
}
    
    func configSearchBar () {
        searchBar = UINavigationBar(frame: CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.width, height: UtilityService.cnfg.barHeight))
        searchBar.backgroundColor = UtilityService.cnfg.BrandLightGray
        view.addSubview(searchBar)
        
        textField = UISearchTextField(frame: CGRect(x: 10, y: 10, width: view.frame.width - 20 , height: UtilityService.cnfg.barHeight - 20 ))
        textField.backgroundColor = UtilityService.cnfg.BrandWhite
        textField.tintColor = UtilityService.cnfg.BrandBlack
        textField.textAlignment = .right
        textField.borderStyle = .none
        searchBar.addSubview(textField)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UtilityService.cnfg.barHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        cell.backgroundColor = UtilityService.cnfg.BrandWhite
        
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
        UtilityService.utlt.constrainWithinSpecificVoid(tableView, searchBar.bottomAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
    }
}


