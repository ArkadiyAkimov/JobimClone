import UIKit

class FilterByJobTypeVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource {
    
    var topCover : UIView!
    
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    var navBarActive: Bool = true
    
    var searchBar : UIView!
    var textField : UISearchTextField!
    
    var cellHeight = Configuration().barHeight * 1.3
    var reference : PublishJobVC!
    var randomColor = RandomColorGenerator()
    
    var radioButtons = [RadioButton]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        configSearchBar()
        
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = .lightGray
            //tableView.isScrollEnabled = false
            tableView.dataSource = self
            tableView.delegate = self
            tableView.contentMode = .center
            tableView.backgroundColor = UtilityService.cnfg.BrandWhite
            
            self.view.addSubview(tableView)
           UtilityService.utlt.constrainWithinSpecificVoid(tableView, searchBar.bottomAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
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
        return AppDataService.jobRepository.allJobTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
            let jobImage = UIImageView(frame: CGRect(x: 10, y: 0, width: cellHeight , height: cellHeight ))
        jobImage.image = AppDataService.jobRepository.allJobTypes[indexPath.row].image
        jobImage.tintColor = randomColor.produceColor()
            cell.addSubview(jobImage)
            
            radioButtons.append(RadioButton())
            radioButtons[indexPath.row] = RadioButton(frame: CGRect(x: view.frame.width - cellHeight , y: 1, width: cellHeight , height: cellHeight ))
            let customImage = UIImageView()
            radioButtons[indexPath.row].customImage = customImage
            radioButtons[indexPath.row].addSubview(radioButtons[indexPath.row].customImage)
            UtilityService.utlt.constrainEquallyWithinVoid(radioButtons[indexPath.row], radioButtons[indexPath.row].customImage, 10, false)
            radioButtons[indexPath.row].customImage.layer.cornerRadius = cellHeight/4
            radioButtons[indexPath.row].customImage.tintColor = UtilityService.cnfg.BrandOrange
            radioButtons[indexPath.row].layer.borderWidth = 4
            radioButtons[indexPath.row].layer.borderColor = UIColor.lightGray.cgColor
        
            radioButtons[indexPath.row].layer.cornerRadius = cellHeight/4
            radioButtons[indexPath.row].transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            cell.addSubview(radioButtons[indexPath.row])
            
            let jobName = UILabel()
             jobName.text = AppDataService.jobRepository.allJobTypes[indexPath.row].name
            jobName.semanticContentAttribute = .forceRightToLeft
            jobName.textColor = UIColor.lightGray
            radioButtons[indexPath.row].customLabel = jobName
        
        if AppDataService.filterRepository.jobTypesIndexes[indexPath.row] {
            radioButtons[indexPath.row].customImage.image = UIImage(systemName: "checkmark")
            radioButtons[indexPath.row].layer.borderColor = UtilityService.cnfg.BrandOrange.cgColor
            radioButtons[indexPath.row].customLabel.textColor = UtilityService.cnfg.BrandOrange
        }
            
            cell.addSubview(jobName)
            UtilityService.utlt.constrainWithinSpecificVoid(jobName, cell.topAnchor, 0, jobImage.trailingAnchor, 0, radioButtons[indexPath.row].leadingAnchor , 0, cell.bottomAnchor, 0)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        if AppDataService.filterRepository.jobTypesIndexes[indexPath.row] == true {
            AppDataService.filterRepository.jobTypesIndexes[indexPath.row] = false
            radioButtons[indexPath.row].customImage.image = nil
            radioButtons[indexPath.row].layer.borderColor = UIColor.lightGray.cgColor
            radioButtons[indexPath.row].customLabel.textColor = UIColor.lightGray
        } else {
            AppDataService.filterRepository.jobTypesIndexes[indexPath.row] = true
            radioButtons[indexPath.row].customImage.image = UIImage(systemName: "checkmark")
            radioButtons[indexPath.row].layer.borderColor = UtilityService.cnfg.BrandOrange.cgColor
            radioButtons[indexPath.row].customLabel.textColor = UtilityService.cnfg.BrandOrange
        }
    }
}


class RadioButton : UIButton {
    var customImage : UIImageView!
    var customLabel : UILabel!
}
