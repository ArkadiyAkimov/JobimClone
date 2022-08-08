import UIKit

class BirthDateEditVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource , userDataDelegate{
    
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    
    var years = [String]()
    var chosenYear = String()
    var pickerView = UIPickerView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    AppDataService.userRepository.subscribe(self)
    for i in 1900...2022{
        years.append(String(i))
    }
    
    navigationController?.navigationBar.isHidden = true
    view.backgroundColor = .clear
    configTopCover()
    configNavBar()
    configTableView()
    
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath[1] < 5 && indexPath[1] != 1 {
            return view.frame.height/9 * 0.75
        } else if indexPath[1] == 1 {
            return view.frame.height/9 * 2.5
        } else {
            return view.frame.height/9 * 2.5
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        switch indexPath[1] {
        case 0:
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: cell.frame.width - 40, height: cell.frame.height))
            label.text = "שנת הלידה שלך"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(label)
            break
        case 1:
            pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
            pickerView.delegate = self
            pickerView.dataSource = self
            cell.addSubview(pickerView)
            break
        case 5:
            let image = UIImageView(image: UIImage(named:"bottomOrangeGuy"))
            image.contentMode = .scaleAspectFit
            cell.addSubview(image)
            UtilityService.utlt.constrainEquallyWithinVoid(cell, image, 0, true)
            break
        default:
            break
        }
        
        
        return cell
    }
    
    func onUserDataUpdated(_ userData: UserData) {
        pickerView.selectRow((Int(AppDataService.userRepository.birthDate!) ?? 0) - 1900, inComponent: 0, animated: false)
    }
    
    func configTableView () {
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
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
    
    
    @objc func saveChoice () {
        AppDataService.userRepository.birthDate = chosenYear
        dismissKeyboardAndDismissSelf()
    }
    
    @objc func dismissKeyboardAndDismissSelf( ) {
        dismissKeyboard()
        dismissSelfFully()
    }
    
    func configNavBar(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UtilityService.cnfg.barHeight , width: UIScreen.main.bounds.width, height: UtilityService.cnfg.barHeight))
        navBar.backgroundColor = .clear
        navBar.isTranslucent = false
        navBar.barTintColor = UtilityService.cnfg.BrandOrange
        navBar.tintColor = UtilityService.cnfg.BrandWhite
        navBar.delegate = self

        navItem = UINavigationItem()
        navItem.title = "עריכת שנת לידה"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBackIcon ), style: .plain, target: self, action: #selector(dismissKeyboardAndDismissSelf))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "שמור" , style: .plain, target: self, action: #selector(saveChoice))
        
        navBar.items = [navItem]

        view.addSubview(navBar)
    }
    
}

extension BirthDateEditVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenYear = years[row]
    }
}

