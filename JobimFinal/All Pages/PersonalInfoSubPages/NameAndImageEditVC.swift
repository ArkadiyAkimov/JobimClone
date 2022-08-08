import UIKit

class NameAndImageEditVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, userDataDelegate {
    
    var topCover : UIView!
    var navBar : UINavigationBar!
    var navItem = UINavigationItem()
    var imageView = UIImageView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var firstName : UITextField!
    var lastName : UITextField!
    
override func viewDidLoad() {
    super.viewDidLoad()
    AppDataService.userRepository!.subscribe(self)
    
    navigationController?.navigationBar.isHidden = true
    view.backgroundColor = .clear
    configTopCover()
    configNavBar()
    
    configTableView()
    
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1 :
            return view.frame.height/9 * 1.5
        case 2 :
            return view.frame.height/9 * 0.5
        case 5 :
            return view.frame.height/9 * 2.5
        default :
            return view.frame.height/9
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.selectionStyle = .none
        switch indexPath[1] {
        case 0:
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: cell.frame.width - 40, height: cell.frame.height))
            label.text = "אנא מלאו את הפרטים הבאים כדי ליצור קשר עם המעסיק"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(label)
            break
        case 1:
            let photoButton = UIButton(frame: CGRect(x: (cell.frame.width - cell.frame.height)/2 , y: 0, width: cell.frame.height, height: cell.frame.height))
            photoButton.backgroundColor = UtilityService.cnfg.BrandWhite
            imageView = UIImageView(image: AppDataService.userRepository.userImage)
            photoButton.addSubview(imageView)
            UtilityService.utlt.constrainEquallyWithinVoid(photoButton , imageView, 0, false)
            photoButton.addTarget(self, action: #selector(choosePhotoSource), for: .touchUpInside)
            
            imageView.layer.borderWidth = 2
                imageView.layer.masksToBounds = false
                imageView.layer.borderColor = UIColor.black.cgColor
                imageView.layer.cornerRadius = photoButton.frame.height/2
                imageView.clipsToBounds = true
            
            cell.addSubview(photoButton)
            break
        case 2:
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: cell.frame.width - 40, height: cell.frame.height))
            label.text = "הסלפי שלי"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(label)
            break
        case 3:
            lastName = UITextField(frame: CGRect(x: 20, y: 10, width: cell.frame.width/2 - 25, height: cell.frame.height - 20))
            lastName.backgroundColor = UtilityService.cnfg.BrandLightGray
            lastName.layer.cornerRadius = 5
            lastName.textAlignment = .center
            lastName.textColor = UtilityService.cnfg.BrandOrange
            //lastName.text = userData!.lastName
            lastName.autocorrectionType = .no
            firstName = UITextField(frame: CGRect(x: cell.frame.width/2 + 5, y: 10, width: cell.frame.width/2 - 25, height: cell.frame.height - 20))
            firstName.backgroundColor = UtilityService.cnfg.BrandLightGray
            firstName.layer.cornerRadius = 5
            firstName.textAlignment = .center
            firstName.textColor = UtilityService.cnfg.BrandOrange
            //firstName.text = userData!.firstName
            firstName.autocorrectionType = .no
            cell.addSubview(lastName)
            cell.addSubview(firstName)
            onUserDataUpdated(AppDataService.userRepository)
            break
        case 4:
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
        imageView.image = AppDataService.userRepository.userImage
        firstName.text = AppDataService.userRepository.firstName
        lastName.text = AppDataService.userRepository.lastName
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
    
    @objc func saveChoice ( ) {
        AppDataService.userRepository.userImage = imageView.image
        AppDataService.userRepository.firstName = firstName.text
        AppDataService.userRepository.lastName = lastName.text
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
        navItem.title = "עריכת שם ותמונה"
        navItem.titleView?.tintColor = .white
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UtilityService.cnfg.NavBackIcon ), style: .plain, target: self, action: #selector(dismissKeyboardAndDismissSelf))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "שמור" , style: .plain, target: self, action: #selector(saveChoice))
        navBar.items = [navItem]

        view.addSubview(navBar)
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType)
                                                            -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        // Get picked image from info dictionary
        imageView.image = (info[.originalImage] as! UIImage)
        imageView.contentMode = .scaleAspectFill
        // Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    @objc func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)

        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            print("Present camera")
            let imagePicker = self.imagePicker(for: .camera)
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        let photoLibraryAction =
                UIAlertAction(title: "Photo Library", style: .default) { _ in
            print("Present photo library")
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            self.present(imagePicker, animated: true , completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
}

