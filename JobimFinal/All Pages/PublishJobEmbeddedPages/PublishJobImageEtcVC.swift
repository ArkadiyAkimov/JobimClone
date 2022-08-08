import UIKit

class PublishJobImageEtcVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate ,jobDataDelegate{
    func onJobDataUpdated(_ jobData: JobData) {
        
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
        UtilityService.unpublishedJob.jobImage = imageView.image
    }
    
    var topCover : UIView!
    var imageView = UIImageView()

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
            label.text = "כמה פרטים אחרונים (לא חובה)"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(label)
            break
        case 1:
            let addImageButton = UIButton(frame: CGRect(x: view.frame.width / 4 * 3, y: 0, width: cell.frame.height, height: cell.frame.height ))
            addImageButton.imageView?.tintColor = UtilityService.cnfg.BrandWhite
            addImageButton.backgroundColor = UtilityService.cnfg.BrandGray
            let imageForButton = UIImageView(image: UIImage(systemName: "camera.viewfinder"))
            imageForButton.frame = addImageButton.bounds
            imageForButton.contentMode = .scaleAspectFill
            imageForButton.tintColor = UtilityService.cnfg.BrandWhite
            addImageButton.addSubview(imageForButton)
            addImageButton.addSubview(imageView)
            UtilityService.utlt.constrainEquallyWithinVoid(addImageButton , imageView, 0, false)
            addImageButton.addTarget(self, action: #selector(choosePhotoSource), for: .touchUpInside)
                imageView.layer.masksToBounds = false
                imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = UtilityService.cnfg.BrandWhite

            
            
            let addImageLabel = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width/4 * 3 - 20, height: cell.frame.height))
            addImageLabel.text = "מומלץ לצרף תמונת אווירה הקשורה לתפקיד או לבית העסק. לא לעלות סתם לוגו..."
            addImageLabel.semanticContentAttribute = .forceRightToLeft
            addImageLabel.numberOfLines = -1
            addImageLabel.adjustsFontSizeToFitWidth = true
            
            cell.addSubview(addImageLabel)
            cell.addSubview(addImageButton)
            break
        case 2:
            let branchName = UIView(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20))
            branchName.layer.cornerRadius = 5
            cell.addSubview(branchName)
            break
        case 3:
            let branchName = UIView(frame: CGRect(x: 20, y: 10, width: cell.frame.width - 40, height: cell.frame.height - 20))
            
            branchName.layer.cornerRadius = 5
            cell.addSubview(branchName)
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
    
    @objc func saveChoice ( ) {
        UtilityService.unpublishedJob.jobImage = imageView.image
        dismissKeyboardAndDismissSelf()
    }
    
    @objc func dismissKeyboardAndDismissSelf( ) {
        dismissKeyboard()
        dismissSelfFully()
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


