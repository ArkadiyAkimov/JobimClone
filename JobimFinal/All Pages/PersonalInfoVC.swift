import UIKit

class PersonalInfoVC: CustomViewController ,UITableViewDelegate, UITableViewDataSource, userDataDelegate{
    
    let jobBrowserView = JobBrowserVC()
    
    var topCover : UIView!
    var coverView = UIView()
    
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    
    var userDataButtons = [CustomUserDataButton]()
    var imageView = UIImageView()
    
    // subpages
    var settingsPage = SettingsVC()
    var nameAndImageEditPage = NameAndImageEditVC()
    var cityOfResidenceEditPage = CityOfResidenceEditVC()
    var birthDateEditPage = BirthDateEditVC()
    var emailAdressEditPage = EmailAdressEditVC()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
override func viewDidLoad() {
    super.viewDidLoad()
    AppDataService.userRepository!.subscribe(self)
    
    view.backgroundColor = UtilityService.cnfg.BrandWhite
    configTopCover()
    configNavBar()
    
    configPageView(settingsPage, true)
    configPageView(nameAndImageEditPage, true)
    configPageView(cityOfResidenceEditPage, true)
    configPageView(birthDateEditPage, true)
    configPageView(emailAdressEditPage, true)
    
    configTriangle()
    configTableView()
}
    
    func onUserDataUpdated(_ userData: UserData) {
        imageView.image =  AppDataService.userRepository.userImage
        userDataButtons[1].setTitle(AppDataService.userRepository.getFullName(), for: .normal)
        userDataButtons[2].setTitle(AppDataService.userRepository.cityOfResidence, for: .normal)
        userDataButtons[3].setTitle(AppDataService.userRepository.birthDate, for: .normal)
        userDataButtons[4].setTitle(AppDataService.userRepository.emailAdress, for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func configTriangle (){
        customTrianlgeView = CustomTriangleView(frame: CGRect(x: -1 , y: view.bounds.height , width: view.bounds.width * 0.15 , height: view.bounds.height))
        view.addSubview(customTrianlgeView)
        customTrianlgeView.backgroundColor = UtilityService.cnfg.BrandWhite
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if 5 > indexPath[1] && indexPath[1] > 0  {
            return view.frame.height/9
        } else if indexPath[1] == 0{
            return view.frame.height/9 * 1.5
        } else if indexPath[1] == 5{
            return view.frame.height/9 * 2.5
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        
        var config = UIButton.Configuration.filled()
        config.titlePadding = 10
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.baseBackgroundColor = UtilityService.cnfg.BrandLightGray
        config.baseForegroundColor = .black
        
        userDataButtons.append(CustomUserDataButton(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20)))
        
        if 5 > indexPath[1] && indexPath[1] > 0  {
            userDataButtons[indexPath.row].configuration = config
            userDataButtons[indexPath.row].semanticContentAttribute = .forceRightToLeft
            switch indexPath[1] {
            case 1: // user fullname edit button
                userDataButtons[indexPath.row].setTitle(AppDataService.userRepository.getFullName(), for: .normal)
                userDataButtons[indexPath.row].setImage(UIImage(systemName: UtilityService.cnfg.FullNameIcon), for: .normal)
                userDataButtons[indexPath.row].addTarget(self, action: #selector(pushToPage(_:)), for: .touchUpInside)
                userDataButtons[indexPath.row].referenceToPage = nameAndImageEditPage
                break
            case 2: // user cityOfResidence edit button
                userDataButtons[indexPath.row].setTitle(AppDataService.userRepository.cityOfResidence, for: .normal)
                userDataButtons[indexPath.row].setImage(UIImage(systemName: UtilityService.cnfg.CityOfResidenceIcon), for: .normal)
                userDataButtons[indexPath.row].imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                userDataButtons[indexPath.row].addTarget(self, action: #selector(pushToPage(_:)), for: .touchUpInside)
                userDataButtons[indexPath.row].referenceToPage = cityOfResidenceEditPage
                break
            case 3: // user birthDate edit button
                userDataButtons[indexPath.row].setTitle(AppDataService.userRepository.birthDate, for: .normal)
                userDataButtons[indexPath.row].setImage(UIImage(systemName: UtilityService.cnfg.BirthDateIcon), for: .normal)
                userDataButtons[indexPath.row].addTarget(self, action: #selector(pushToPage(_:)), for: .touchUpInside)
                userDataButtons[indexPath.row].referenceToPage = birthDateEditPage
                break
            case 4: // user emailAdress edit button
                userDataButtons[indexPath.row].setTitle(AppDataService.userRepository.emailAdress, for: .normal)
                userDataButtons[indexPath.row].setImage(UIImage(systemName: UtilityService.cnfg.EmailAdressIcon), for: .normal)
                userDataButtons[indexPath.row].addTarget(self, action: #selector(pushToPage(_:)), for: .touchUpInside)
                userDataButtons[indexPath.row].referenceToPage = emailAdressEditPage
                break
            default:
                break
            }
            userDataButtons[indexPath.row].setTitleColor(UtilityService.cnfg.BrandOrange , for: .normal)
            userDataButtons[indexPath.row].backgroundColor = UtilityService.cnfg.BrandLightGray
            userDataButtons[indexPath.row].contentHorizontalAlignment = .right
            userDataButtons[indexPath.row].layer.cornerRadius = UtilityService.cnfg.cornerRadius
            cell.addSubview((userDataButtons[indexPath.row]))
        }
        
        if indexPath[1] == 0 { // user image and fullname button
            if AppDataService.userRepository.userImage != nil {
            let photoButton = CustomUserDataButton(frame: CGRect(x: (cell.frame.width - cell.frame.height)/2 , y: 0, width: cell.frame.height, height: cell.frame.height))
            photoButton.backgroundColor = UtilityService.cnfg.BrandWhite
            photoButton.addSubview(imageView)
            UtilityService.utlt.constrainEquallyWithinVoid(photoButton,imageView, 10, false)
            photoButton.addTarget(self, action: #selector(pushToPage(_:)), for: .touchUpInside)
            photoButton.referenceToPage = nameAndImageEditPage
            
            imageView.layer.borderWidth = 2
            imageView.layer.masksToBounds = false
            imageView.layer.borderColor = UIColor.black.cgColor
            imageView.layer.cornerRadius = photoButton.frame.height/2 - 10
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            cell.addSubview(photoButton)
            }
        }
        
        if indexPath[1] == 5 {
            let image = UIImageView(image: UIImage(named:"bottomOrangeGuy"))
            image.contentMode = .scaleAspectFit
            cell.addSubview(image)
            UtilityService.utlt.constrainEquallyWithinVoid(cell, image, 10, true)
            onUserDataUpdated(AppDataService.userRepository)
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
    
    func configNavBar(){
        navBar = UINavigationBar(frame: CGRect(x: 0, y: UtilityService.cnfg.barHeight , width: UIScreen.main.bounds.width, height: UtilityService.cnfg.barHeight))
        navBar.backgroundColor = .clear
        navBar.isTranslucent = false
        navBar.barTintColor = UtilityService.cnfg.BrandOrange
        navBar.tintColor = UtilityService.cnfg.BrandWhite
        
        navItem = UINavigationItem()
        navItem.title = "הפרטים שלי"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBarMenuIcon), style: .plain, target: self, action: #selector(pushMenu))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "הגדרות", style: .plain, target: self, action: #selector(pushSettingsPage))
        navBar.items = [navItem]
        view.addSubview(navBar)
    }
    
    func configPageView(_ page: SimpleViewController,_ dismiss:Bool){
        addChild(page)
        page.didMove(toParent: self)
        view.addSubview(page.view)
        UtilityService.utlt.constrainEquallyWithinVoid(view, page.view, 0, false)
        if dismiss {
        page.dismissSelfFully()
        }
    }
    
    @objc func pushSettingsPage () {
        pushPageView(settingsPage)
    }
    
    @objc func pushToPage (_ sender: CustomUserDataButton){
        pushPageView(sender.referenceToPage)
    }
    
    @objc func pushPageView (_ pageView: SimpleViewController) {
        view.bringSubviewToFront(pageView.view)
        pageView.view.addSubview(coverView)
        AppDataService.userRepository.updateData()
        
        UtilityService.utlt.constrainEquallyWithinVoid(pageView.view, coverView, 0, false)
        pageView.view.bringSubviewToFront(self.coverView)
        UIView.animate(withDuration: 0.3, delay: 0) {
            pageView.view.transform = CGAffineTransform.identity
            self.coverView.alpha = 0
        }
    }
}

class CustomUserDataButton : UIButton {
    var referenceToPage : SimpleViewController!
}
