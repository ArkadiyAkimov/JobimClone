import UIKit

class PublishContactsVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, jobDataDelegate{
    
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    var PublishJobPage : PublishJobVC!
    
    var phoneNumber : UITextField!
    var messageNumber : UITextField!
    var emailAdress : UITextField!
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    AppDataService.jobRepository.subscribe(self)
    navigationController?.navigationBar.isHidden = true
    view.backgroundColor = UtilityService.cnfg.BrandWhite
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
        if indexPath[1] < 4 {
            return view.frame.height/9 * 0.75
        } else if indexPath[1] == 4 {
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
            phoneNumber = UITextField(frame: CGRect(x: 20, y: 10 , width: cell.frame.width - 40, height: cell.frame.height - 20 ))
            phoneNumber.backgroundColor = UtilityService.cnfg.BrandLightGray
            phoneNumber.layer.cornerRadius = 5
            phoneNumber.textAlignment = .right
            phoneNumber.rightViewMode = .always
            phoneNumber.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: phoneNumber.frame.height))
            phoneNumber.textColor = UtilityService.cnfg.BrandOrange
            //city.text = userData!.cityOfResidence
            phoneNumber.placeholder = "מספר טלפון להתקשרות"
            phoneNumber.autocorrectionType = .no
            cell.addSubview(phoneNumber)
        case 1:
            messageNumber = UITextField(frame: CGRect(x: 20, y: 10 , width: cell.frame.width - 40, height: cell.frame.height - 20 ))
            messageNumber.backgroundColor = UtilityService.cnfg.BrandLightGray
            messageNumber.layer.cornerRadius = 5
            messageNumber.textAlignment = .right
            messageNumber.rightViewMode = .always
            messageNumber.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: messageNumber.frame.height))
            messageNumber.textColor = UtilityService.cnfg.BrandOrange
            //city.text = userData!.cityOfResidence
            messageNumber.placeholder = "מספר טלפון לסמס"
            messageNumber.autocorrectionType = .no
            cell.addSubview(messageNumber)
            break
        case 2:
            emailAdress = UITextField(frame: CGRect(x: 20, y: 10 , width: cell.frame.width - 40, height: cell.frame.height - 20 ))
            emailAdress.backgroundColor = UtilityService.cnfg.BrandLightGray
            emailAdress.layer.cornerRadius = 5
            emailAdress.textAlignment = .right
            emailAdress.rightViewMode = .always
            emailAdress.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: emailAdress.frame.height))
            emailAdress.textColor = UtilityService.cnfg.BrandOrange
            //city.text = userData!.cityOfResidence
            emailAdress.placeholder = "כתובת מייל ליצירת קשר"
            emailAdress.autocorrectionType = .no
            cell.addSubview(emailAdress)
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
    
    @objc func publishJobFinal () {
        dismissKeyboardAndDismissSelf()
        
        PublishJobPage.reloadOriginalSegmentIcons()
        PublishJobPage.segmentedControl.selectedSegmentIndex = 0
        PublishJobPage.segmentedControlChange(sender: PublishJobPage.segmentedControl)
        PublishJobPage.dimSegmentCovers()
        
            AppDataService.jobRepository.updateUnpublishedJobData()
            AppDataService.jobRepository.allJobs.append(UtilityService.unpublishedJob)
            UtilityService.unpublishedJob = Job(random: false)
            AppDataService.filterRepository.mainProcess()
        print("published!")
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
        navItem.title = "אמצעי יצירת קשר"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBackIcon ), style: .plain, target: self, action: #selector(dismissKeyboardAndDismissSelf))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "פרסם" , style: .plain, target: self, action: #selector(publishJobFinal))
        
        navBar.items = [navItem]

        view.addSubview(navBar)
    }
    
    func onJobDataUpdated(_ jobData: JobData) {
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
        UtilityService.unpublishedJob.jobPhone = phoneNumber.text
        UtilityService.unpublishedJob.jobMessage = messageNumber.text
        UtilityService.unpublishedJob.jobEmailAdress = emailAdress.text
    }
}

