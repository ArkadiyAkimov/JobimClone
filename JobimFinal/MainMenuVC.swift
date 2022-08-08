import UIKit

class MainMenuVC : CustomViewController , UITableViewDelegate, UITableViewDataSource, userDataDelegate {
   
    let customMenuView = MenuCustomOverlayView()
    var menuItemSelectionRect = [UIView]()
    var menuItemSelectionRectFrame = [UIView]()
    var menuItemImageFrame = [UIView]()
    var menuItemLabelFrame = [UIView]()
    var menuItemCells = [UITableViewCell]()
    var returnToLastViewMenuTransparentButton = menuCustomButton()
    var coverView = UIView()

    var userFullNameLabel = UILabel()
    var userImageView = UIImageView()
    
    var pageViews = [UIViewController]()
    var lastPageVisited : CustomViewController!
    
    var frontPage = FrontPageVC()
    var personalInfoPage = PersonalInfoVC()
    var notificationsPage = NotificationsVC()
    var myJobsPage = MyJobsVC()
    var smartAgentPage = SmartAgentVC()
    var aboutPage = AboutVC()
    var publishJobPage = PublishJobVC()
    
    
    private let menuTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDataService.userRepository!.subscribe(self)
        view.backgroundColor = UtilityService.cnfg.BrandWhite
        
        configCustomMenuView()
        configTableView()
        configUserDataTopView()
        configBottomLogoView()
        
        configCustomPageView(personalInfoPage, true)
        configCustomPageView(notificationsPage, true)
        configCustomPageView(myJobsPage, true)
        configCustomPageView(smartAgentPage, true)
        configCustomPageView(aboutPage, true)
        configCustomPageView(publishJobPage, true)
        configCustomPageView(frontPage, false) //false for don't dismiss
        lastPageVisited = frontPage // the page displayed on top of stack
        
        configReturnToLastViewMenuTransparentButton()
        }
    
    func onUserDataUpdated(_ userData: UserData) {
         userFullNameLabel.text = AppDataService.userRepository.getFullName()
        userImageView.image = AppDataService.userRepository.userImage
     }
    
    func configUserDataTopView () {
        
        let userDataTopView = UIView()
        view.addSubview(userDataTopView)
        UtilityService.utlt.constrainWithinSpecificVoid(userDataTopView, view.safeAreaLayoutGuide.topAnchor,  -20, view.leadingAnchor, 0, view.trailingAnchor, 0, menuTableView.topAnchor , 0 )
        
        let userImageButton = UIButton(frame: CGRect(x: view.frame.width/2 - 40 , y: 0, width: 80, height: 80))
        userImageButton.backgroundColor = UtilityService.cnfg.BrandWhite
        userImageButton.addTarget(self, action: #selector(pushPersonalInfoPage), for: .touchUpInside)
        userImageButton.addSubview(userImageView)
        UtilityService.utlt.constrainEquallyWithinVoid(userImageButton, userImageView, 10, false)
        
        userImageView.layer.masksToBounds = false
        userImageView.layer.cornerRadius = userImageButton.frame.height/2 - 10
        userImageView.layer.borderWidth = 1
        userImageView.layer.borderColor = UIColor.black.cgColor
    
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFill
        
        userFullNameLabel = UILabel(frame: CGRect(x: 0, y: 80, width: view.frame.width , height: 20))
        userFullNameLabel.textAlignment = .center
        userFullNameLabel.transform = CGAffineTransform.init(scaleX: 1, y: 1.2)
        
        userDataTopView.addSubview(userImageButton)
        userDataTopView.addSubview(userFullNameLabel)
        userDataTopView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        onUserDataUpdated(AppDataService.userRepository)
    }
    
    func configBottomLogoView() {
        let logoView = UIImageView(image: UIImage(named: "bottomLogo"))
        view.addSubview(logoView)
        UtilityService.utlt.constrainWithinSpecificVoid(logoView, menuTableView.bottomAnchor, 0, view.leadingAnchor, 0, view.trailingAnchor, 0, view.safeAreaLayoutGuide.bottomAnchor, 0)
        logoView.contentMode = .scaleAspectFit
    }
    
    func configCustomPageView(_ page: CustomViewController,_ dismiss:Bool){
        addChild(page)
        page.didMove(toParent: self)
        page.mainMenu = self
        view.addSubview(page.view)
        UtilityService.utlt.constrainEquallyWithinVoid(view, page.view, 0, false)
        if dismiss {
        page.dismissSelfPartially()
        }
    }
    
    func configCustomMenuView() {
        view.addSubview(customMenuView)
        UtilityService.utlt.constrainEquallyWithinVoid(view, customMenuView, 0, false)
        customMenuView.backgroundColor = UtilityService.cnfg.BrandWhite
    }
            
            override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                menuTableView.frame = view.bounds
            }
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return 7
            }
            
            
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if indexPath.row > 2 {
                let cellHeight = view.bounds.height/11
                    return cellHeight
                } else {
                    let cellHeight = view.bounds.height/14
                        return cellHeight
                }
                
            }
            
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let menuItemCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                menuItemCell.selectionStyle = .none
                menuItemCells.append(menuItemCell)
                
                let cellPadding = UtilityService.cnfg.barHeight
                let cellWidth = view.bounds.width
                let cellHeight = view.bounds.height/11
                let specificHeight = menuItemCells[indexPath.row].bounds.height
                
                menuItemLabelFrame.append(UIView(frame:
                CGRect(x: cellPadding , y: menuItemCell.bounds.midY/2 , width: cellWidth/2 , height: cellHeight/2 )))
                menuItemLabelFrame[indexPath.row].contentMode = .center
                let menuItemLabel = UILabel(frame: CGRect(x:0 , y: 0, width: cellWidth/2 , height: cellHeight/2 ))
                menuItemLabel.text = "פריט תפריט פריט תפריט \(indexPath.row)"
                menuItemLabel.textColor = .black
                menuItemLabel.font = UIFont.systemFont(ofSize: 22)
                menuItemLabel.semanticContentAttribute = .forceRightToLeft
                menuItemLabel.textAlignment = .right
                menuItemLabel.transform = CGAffineTransform(translationX: 0, y: -2)
                
                menuItemLabelFrame[indexPath.row].addSubview(menuItemLabel)
                menuItemCell.addSubview(menuItemLabelFrame[indexPath.row])
                
                let menuItemImage = UIImageView()
                menuItemImageFrame.append(menuItemImage)
                menuItemImage.tintColor = .black
                menuItemImage.frame = CGRect(x: cellPadding + menuItemLabel.bounds.width + 10 , y: menuItemCell.bounds.midY/2 , width: cellHeight/2 , height: cellHeight/2 )
                menuItemCell.addSubview(menuItemImage)
                
                if indexPath.row > 2 {
                    menuItemLabel.textColor = UtilityService.cnfg.BrandOrange
                    menuItemImage.tintColor = UtilityService.cnfg.BrandOrange
                    let border = UIView(frame: CGRect(x: 0, y: 0 , width: cellWidth, height: 1))
                    border.backgroundColor = .black
                    menuItemCell.addSubview(border)
                }
                
                if indexPath.row == 6 {
                    let border = UIView(frame: CGRect(x: 0, y: cellHeight , width: cellWidth, height: 1))
                    border.backgroundColor = .black
                    menuItemCell.addSubview(border)
                }
                
                menuItemSelectionRect.append(UIView(frame: CGRect(x: -10 , y: 0 , width: 10, height: specificHeight  )))
                menuItemSelectionRectFrame.append(UIView(frame: CGRect(x: -10 , y: 0 , width: 10, height: specificHeight)))
                menuItemSelectionRect[indexPath.row].backgroundColor = UtilityService.cnfg.BrandOrange
                menuItemSelectionRectFrame[indexPath.row].addSubview(menuItemSelectionRect[indexPath.row])
                menuItemSelectionRectFrame[indexPath.row].backgroundColor = .clear
                menuItemCell.addSubview(menuItemSelectionRectFrame[indexPath.row])
                self.view.bringSubviewToFront(menuItemSelectionRectFrame[indexPath.row])
                
                switch indexPath.row{
                case 0:
                    menuItemLabel.text = UtilityService.cnfg.PersonalMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.PersonalMenuIcon )
                    break
                case 1:
                    menuItemLabel.text = UtilityService.cnfg.NotificationsMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.NotificationsMenuIcon )
                    break
                case 2:
                    menuItemLabel.text = UtilityService.cnfg.MyJobsMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.MyJobsMenuIcon )
                    break
                case 3:
                    menuItemLabel.text = UtilityService.cnfg.MainPageMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.MainPageMenuIcon )
                    break
                case 4:
                    menuItemLabel.text = UtilityService.cnfg.SmartAgentMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.SmartAgentMenuIcon )
                    break
                case 5:
                    menuItemLabel.text = UtilityService.cnfg.AboutMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.AboutMenuIcon )
                    break
                case 6:
                    menuItemLabel.text = UtilityService.cnfg.PublishJobMenuText
                    menuItemImage.image = UIImage(systemName: UtilityService.cnfg.PublishJobMenuIcon )
                    menuItemLabel.font = UIFont.boldSystemFont(ofSize: 22)
                    menuItemLabel.textColor = UtilityService.cnfg.BrandGray
                    menuItemImage.tintColor = UtilityService.cnfg.BrandGray
                    break
                default:
                    break
                }
                
                return menuItemCell
            }
           
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionRectAnimation(indexPath.row)
        openCorrespondingPage(indexPath.row)
    }
    
    func selectionRectAnimation (_ index: Int ) {
        
        menuItemSelectionRect[index].transform = CGAffineTransform(translationX: 0 , y: 0)
        //selectionRect[index].backgroundColor =
        UIWindow.animate(withDuration: 0.15) {
            self.menuItemSelectionRect[index].backgroundColor = UtilityService.cnfg.BrandOrange
            self.menuItemSelectionRect[index].transform = CGAffineTransform(translationX: 18 , y: 0)
            self.menuItemSelectionRectFrame[index].transform = CGAffineTransform.identity
            self.menuItemImageFrame[index].transform = CGAffineTransform(rotationAngle: .pi )
            self.menuItemImageFrame[index].transform = CGAffineTransform(rotationAngle: 2 * .pi )
            self.menuItemImageFrame[index].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.menuItemLabelFrame[index].transform = CGAffineTransform(translationX: -50, y: 0)
            self.menuItemLabelFrame[index].alpha = 0
            
            for i in 1...6 {
              if index - i > -1 {
                  self.menuItemSelectionRect[index - i ].backgroundColor = UIColor(hue: 0.079, saturation: CGFloat( 1.08 - Double(i)/5 ) , brightness: CGFloat( 1 + Double(i)/5 ), alpha: 0.5)
                  self.menuItemSelectionRect[index - i ].transform = CGAffineTransform(translationX: CGFloat( 20 - Double(i) * 2 ) , y: 0)
              }
              if index + i < 7  {
                  self.menuItemSelectionRect[index + i ].backgroundColor = UIColor(hue: 0.079, saturation: CGFloat( 1.08 - Double(i)/5 ) , brightness: CGFloat( 1 + Double(i)/5 ), alpha: 0.5)
                  self.menuItemSelectionRect[index + i ].transform = CGAffineTransform(translationX: CGFloat( 20 - Double(i) * 2 ) , y: 0)
              }
            }
        } completion: { Bool in
            UIWindow.animate(withDuration: 0.15, delay: 0) {
                for i in 1...6 {
                  if index - i > -1 {
                      self.menuItemSelectionRect[index - i ].transform = CGAffineTransform.identity
                      self.menuItemSelectionRectFrame[index - i ].transform = CGAffineTransform.identity
                      self.menuItemSelectionRect[index - i].backgroundColor = .black
                  }
                  if index + i < 7  {
                      self.menuItemSelectionRect[index + i ].transform = CGAffineTransform.identity
                      self.menuItemSelectionRectFrame[index + i ].transform = CGAffineTransform.identity
                      self.menuItemSelectionRect[index + i].backgroundColor = .black
                  }
                }
                self.menuItemImageFrame[index].transform = CGAffineTransform.identity
                self.menuItemLabelFrame[index].alpha = 1
                self.menuItemLabelFrame[index].transform =
                CGAffineTransform.identity
            }
        }
    }
    
    @objc func pushPersonalInfoPage(){
        openSpecifiedPage(personalInfoPage)
    }
    
    func openSpecifiedPage (_ page: CustomViewController){
        pageTransitionEffect(page)
        pushPageView(page)
        lastPageVisited = page
    }
    
    func pageTransitionEffect (_ thisPage: CustomViewController) {
        if lastPageVisited != thisPage {
            coverView.alpha = 0.8
        }
    }
    
    func openCorrespondingPage (_ menuButtonIndex: Int) {
        switch menuButtonIndex {
        case 0:
            openSpecifiedPage(personalInfoPage)
            break
        case 1:
            openSpecifiedPage(notificationsPage)
            break
        case 2:
            openSpecifiedPage(myJobsPage)
            break
        case 3:
            openSpecifiedPage(frontPage)
            break
        case 4:
            openSpecifiedPage(smartAgentPage)
            break
        case 5:
            openSpecifiedPage(aboutPage)
            break
        case 6:
            openSpecifiedPage(publishJobPage)
            break
        default:
            break
        }
    }
    
            func configTableView () {
                menuTableView.dataSource = self
                menuTableView.delegate = self
                menuTableView.contentMode = .center
                menuTableView.backgroundColor = .clear
                menuTableView.isScrollEnabled = false
                menuTableView.separatorStyle = .none
                
                customMenuView.addSubview(menuTableView)
                menuTableView.translatesAutoresizingMaskIntoConstraints = false
                menuTableView.leadingAnchor.constraint(equalTo: customMenuView.leadingAnchor).isActive = true
                menuTableView.trailingAnchor.constraint(equalTo: customMenuView.trailingAnchor).isActive = true
                menuTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor ).isActive = true
                menuTableView.heightAnchor.constraint(equalToConstant: view.bounds.height/11 * 7).isActive = true
            }
    
    @objc func pushLastPageVisited (){
        pushPageView(lastPageVisited)
    }
   
    @objc func pushPageView (_ pageView: CustomViewController) {
        view.bringSubviewToFront(pageView.view)
        pageView.view.addSubview(coverView)
        UtilityService.utlt.constrainEquallyWithinVoid(pageView.view, coverView, 0, false)
        pageView.view.bringSubviewToFront(self.coverView)
        pageView.view.bringSubviewToFront(pageView.customTrianlgeView)
        UIView.animate(withDuration: 0.3, delay: 0) {
            pageView.view.transform = CGAffineTransform.identity
            self.returnToLastViewMenuTransparentButton.transform = CGAffineTransform(translationX:
            self.returnToLastViewMenuTransparentButton.bounds.width, y: 0)
            self.coverView.alpha = 0
            pageView.customTrianlgeView.transform = CGAffineTransform.identity
        }
    }
    
        @objc func pushSelf () {
            view.bringSubviewToFront(returnToLastViewMenuTransparentButton)
            coverView.backgroundColor = .black
            coverView.alpha = 0
            //self.customView.sendSubviewToBack(coverView)
            UIView.animate(withDuration: 0.3, delay: 0) {
                //self.customView.transform = CGAffineTransform.identity
                self.returnToLastViewMenuTransparentButton.transform = CGAffineTransform.identity
                self.coverView.alpha = 0.4
        }
    }
    
    func configReturnToLastViewMenuTransparentButton(){
        view.addSubview(returnToLastViewMenuTransparentButton)
        returnToLastViewMenuTransparentButton.backgroundColor = .clear
        returnToLastViewMenuTransparentButton.frame = CGRect(x: view.bounds.maxX * 0.85 , y: 0, width: view.bounds.width, height: view.bounds.height )
        returnToLastViewMenuTransparentButton.addTarget(self, action: #selector(pushLastPageVisited), for: .touchUpInside)
        returnToLastViewMenuTransparentButton.transform = CGAffineTransform(translationX: returnToLastViewMenuTransparentButton.bounds.width, y: 0)
    }
}

