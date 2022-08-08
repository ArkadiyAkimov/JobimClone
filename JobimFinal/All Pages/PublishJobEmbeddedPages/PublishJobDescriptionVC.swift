import UIKit
import MapKit

class PublishJobDescriptionVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, jobDataDelegate {
    func onJobDataUpdated(_ jobData: JobData) {
        
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
        UtilityService.unpublishedJob.jobTitleFromNameAndType(UtilityService.unpublishedJob)
        companyAndJobTypeLabel.text = UtilityService.unpublishedJob.jobTitle
        
        UtilityService.unpublishedJob.jobDescriptionTitle = jobDescriptionTitle.text!
        UtilityService.unpublishedJob.jobDescriptionBody = jobDescriptionBody.text!
    }
    
    var topCover : UIView!
    var companyAndJobTypeLabel = UILabel()
    var jobDescriptionTitle = UITextField()
    var jobDescriptionBody = UITextView()
    
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
        switch indexPath.row {
        case 2:
            return view.frame.height/9 * 2.3
        case 5:
            return view.frame.height/9 * 2.5
        default:
            return view.frame.height/9
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        switch indexPath[1] {
        case 0:
            companyAndJobTypeLabel = UILabel(frame: CGRect(x: 20, y: 0, width: cell.frame.width - 40, height: cell.frame.height))
            
            companyAndJobTypeLabel.numberOfLines = 2
            companyAndJobTypeLabel.textAlignment = .center
            companyAndJobTypeLabel.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(companyAndJobTypeLabel)
            break
        case 1:
            jobDescriptionTitle = UITextField(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20))
            jobDescriptionTitle.backgroundColor = UtilityService.cnfg.BrandLightGray
            jobDescriptionTitle.layer.cornerRadius = 5
            jobDescriptionTitle.textAlignment = .right
            jobDescriptionTitle.rightViewMode = .always
            jobDescriptionTitle.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: UtilityService.cnfg.barHeight))
            jobDescriptionTitle.textColor = UtilityService.cnfg.BrandOrange
            jobDescriptionTitle.placeholder = "כותרת קולעת (עד 50 תווים)"
            jobDescriptionTitle.autocorrectionType = .no
            cell.addSubview(jobDescriptionTitle)
            break
        case 2:
            let jobDescriptionBackground = UIView(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20))
            jobDescriptionBackground.backgroundColor = UtilityService.cnfg.BrandLightGray
            jobDescriptionBody = UITextView()
            jobDescriptionBody.delegate = self
            jobDescriptionBackground.addSubview(jobDescriptionBody)
            jobDescriptionBackground.layer.cornerRadius = 5
            UtilityService.utlt.constrainEquallyWithinVoid(jobDescriptionBackground, jobDescriptionBody, 10, false)
            jobDescriptionBody.backgroundColor = .clear
            jobDescriptionBody.textAlignment = .right
            jobDescriptionBody.font = UIFont.preferredFont(forTextStyle: .body)
            jobDescriptionBody.text = "תנו תיאור קצר של הג׳וב ב2/3 משפטים"
            jobDescriptionBody.textColor = UIColor.lightGray
            jobDescriptionBody.autocorrectionType = .no
            cell.addSubview(jobDescriptionBackground)
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UtilityService.cnfg.BrandOrange
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = "תנו תיאור קצר של הג׳וב ב2/3 משפטים"
                textView.textColor = UIColor.lightGray
            }
        }
    }
}


