import UIKit

class PublishJobCompanyNameVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, jobDataDelegate {
    func onJobDataUpdated(_ jobData: JobData) {
        
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
        UtilityService.unpublishedJob.companyName = companyName.text!
        UtilityService.unpublishedJob.branchName = branchName.text!
    }
    
    var topCover : UIView!
    var companyName = UITextField()
    var branchName = UITextField()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    AppDataService.jobRepository.subscribe(self)
    view.backgroundColor = UtilityService.cnfg.BrandWhite
    configTableView()
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            return view.frame.height/9 * 2.5
        } else if indexPath.row == 4{
            return view.frame.height/9 * 2.3
        } else {
            return view.frame.height/9
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        switch indexPath[1] {
        case 0:
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: cell.frame.width - 40, height: cell.frame.height))
            label.text = "אנא מלאו את הפרטים הבאים כדי ליצור ג׳וב חדש"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(label)
            break
        case 1:
            companyName = UITextField(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20))
            companyName.backgroundColor = UtilityService.cnfg.BrandLightGray
            companyName.layer.cornerRadius = 5
            companyName.textAlignment = .right
            companyName.rightViewMode = .always
            companyName.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: UtilityService.cnfg.barHeight))
            companyName.textColor = UtilityService.cnfg.BrandOrange
            companyName.placeholder = "שם החברה"
            companyName.autocorrectionType = .no
            cell.addSubview(companyName)
            break
        case 2:
            branchName = UITextField(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20))
            branchName.backgroundColor = UtilityService.cnfg.BrandLightGray
            branchName.layer.cornerRadius = 5
            branchName.textAlignment = .right
            branchName.rightViewMode = .always
            branchName.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: UtilityService.cnfg.barHeight))
            branchName.textColor = UtilityService.cnfg.BrandOrange
            branchName.placeholder = "שם הסניף (לא חובה)"
            branchName.autocorrectionType = .no
            cell.addSubview(branchName)
            break
        case 3:
            break
        case 4:
            break
        case 5:
            let image = UIImageView(image: UIImage(named:"bottomOrangeGuy"))
            image.contentMode = .scaleAspectFit
            cell.addSubview(image)
            UtilityService.utlt.constrainEquallyWithinVoid(cell, image, 0, false)
            break
        default:
            break
        }
        return cell
    }
    
    func configTableView () {
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentMode = .center
        tableView.backgroundColor = UtilityService.cnfg.BrandWhite
        
        self.view.addSubview(tableView)
        UtilityService.utlt.constrainWithinSpecificVoid(tableView, view.topAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.bottomAnchor, 0)
        
    }
}


