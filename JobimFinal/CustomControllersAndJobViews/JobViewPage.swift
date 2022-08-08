import UIKit
import MapKit

class JobViewPage : UIViewController {
    
    var bottomViewContainer = UIView()
    var parentJobView : JobView!
    var job : Job!
    
    private let mapView = MKMapView()
    private let mapManager = CLLocationManager()
    
    var longDescriptionLabel = UILabel()
    var longDescriptionView = UIView()
    var mapViewerContainer = UIView()
    var scrollView = UIScrollView()
    var distanceLabel = UILabel()
    var distance : CLLocationDistance!
    var bottomVisualDecorationUnderview : PageUnderView!
    
    var contactsButtons = [CustomContactButton]()
    
    let stndHeight = UtilityService.cnfg.barHeight - 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapManager.requestWhenInUseAuthorization()
        mapManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        //mapView.isScrollEnabled = false
        mapView.delegate = self
        //mapView.setUserTrackingMode(.follow, animated: true)
        mapView.tintColor = UtilityService.cnfg.BrandOrange
        
        job = AppDataService.jobRepository.allJobs[parentJobView.jobIndex]
        
        if job.jobRawLocation == nil {
        CLGeocoder().geocodeAddressString(job.jobLocation) { (placemarks, error) in
            if error == nil {
            let placemark = placemarks![0].location
            let jobAnnotation = MKPointAnnotation()
            jobAnnotation.title = "job"
            jobAnnotation.coordinate = placemark!.coordinate
            self.mapView.addAnnotation(jobAnnotation)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            } else {
                print(error.debugDescription)
            }
        }
        } else {
            let jobAnnotation = MKPointAnnotation()
            jobAnnotation.title = "job"
            jobAnnotation.coordinate = job.jobRawLocation
            self.mapView.addAnnotation(jobAnnotation)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
        
        let stndWidth = view.frame.width
        
        
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView.showsVerticalScrollIndicator = false
        if job.jobImage != nil {
        scrollView.contentSize = CGSize(width: stndWidth , height: stndHeight * 20  * 1.25)
        } else {
        scrollView.contentSize = CGSize(width: stndWidth , height: stndHeight * 20 )
        }
        view.addSubview(scrollView)
        //tableView.separatorStyle = .none /
        
        let innerCell = UIButton(frame: CGRect(x: 10, y: 20, width: stndWidth - 20, height: stndHeight * 5))
        //innerCell.backgroundColor = parentJobView.innerCell.backgroundColor
        view.addSubview(innerCell)

        
        
        let titleLabel = UILabel(frame: CGRect(x: 0 , y: 0, width: stndWidth - 10 , height: stndHeight ))
        titleLabel.text = job.jobTitle
        
        titleLabel.textAlignment = .center
        titleLabel.clipsToBounds = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        let titleImage = UIView(frame: CGRect(x: 0, y: stndHeight , width: stndWidth , height: stndHeight * 2))
        let titleImageView = UIImageView(image: job.jobType.image)
        titleImageView.frame = CGRect(x: view.frame.width/2 - 40 , y: 0, width: stndHeight * 2, height: stndHeight * 2)
        
        titleImageView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        titleImageView.layer.masksToBounds = false
        
        titleImageView.layer.cornerRadius = stndHeight
        
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.clipsToBounds = true
        titleImageView.tintColor = .white
        
        titleImage.addSubview(titleImageView)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: stndHeight * 3 - 10, width: innerCell.frame.width, height: stndHeight * 2 ))
        subtitleLabel.text = job.jobDescriptionTitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white
        subtitleLabel.transform = CGAffineTransform(scaleX: 0.95, y: 1)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
    
        innerCell.addSubview(titleLabel)
        innerCell.addSubview(titleImage)
        innerCell.addSubview(subtitleLabel)
        
        scrollView.addSubview(innerCell)
        

        var subView = UIView(frame: CGRect(x: 0, y: innerCell.frame.height + stndHeight * 5.7 , width: stndWidth, height: stndHeight * 3))
        
        if job.jobImage != nil {
        let largerImage = JobBrowserImageCutout(frame: CGRect(x: 0, y: innerCell.frame.height , width: view.bounds.width, height: stndHeight * 5.7 ))
        
            
        largerImage.image = job.jobImage
        largerImage.contentMode = .scaleAspectFill
        largerImage.clipsToBounds = true
        scrollView.addSubview(largerImage)
        } else {
            subView = JobViewContactsCutout(frame: CGRect(x: 0 , y: innerCell.frame.height , width: stndWidth, height: stndHeight * 3.5 ))
        scrollView.addSubview(subView)
        subView.backgroundColor = .white
        }
        
        scrollView.addSubview(subView)
        subView.backgroundColor = .white
        
        let stackMenu = UIStackView(frame: CGRect(x: 10, y: subView.frame.height - stndHeight * 3 + 10 , width: stndWidth - 20, height: stndHeight * 3 ))
        stackMenu.distribution = .fillEqually
        subView.addSubview(stackMenu)
        
        
        for i in 0...2 {
            let contactButton = CustomContactButton()
            //contactButton.backgroundColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
            contactsButtons.append(contactButton)
            stackMenu.addArrangedSubview(contactsButtons[i])
            
            contactsButtons[i].index = i
            let image = UIImageView(frame: CGRect(x: (stndWidth/3 - stndHeight * 2)/2 , y: 0, width: stndHeight * 2 , height: stndHeight * 2))
            contactsButtons[i].customImage = image
            let label = UILabel(frame: CGRect(x: 0, y: stndHeight * 2 - 8 , width: stndWidth/3 , height: stndHeight))
            contactsButtons[i].customLabel = label
            switch i {
            case 0:
            image.image = UIImage(systemName: "envelope.circle.fill")
            label.text = "שלח מייל"
                break
            case 1:
                image.image = UIImage(systemName: "phone.circle.fill")
                label.text = "התקשר"
                break
            case 2:
                image.image = UIImage(systemName: "message.circle.fill")
                label.text = "שלח הודעה"
                break
            default:
                break
            }
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = UtilityService.cnfg.BrandOrange
            image.tintColor = UtilityService.cnfg.BrandOrange
            contactsButtons[i].addSubview(image)
            contactsButtons[i].addSubview(label)
            contactsButtons[i].imageView?.contentMode = .scaleAspectFit
            contactsButtons[i].transform = CGAffineTransform(scaleX: 0.85, y: 0.8)
            contactsButtons[i].addTarget(self, action: #selector(contactButtonClick(_:)), for: .touchUpInside)
        }
        
        
        longDescriptionView = UIView(frame: CGRect(x: 0, y: subView.frame.maxY , width: stndWidth, height: stndHeight * 4))
        scrollView.addSubview(longDescriptionView)
        longDescriptionView.backgroundColor = .white
        longDescriptionLabel = UILabel(frame: CGRect(x: 15, y: 0, width: stndWidth - 30, height: stndHeight * 3.5))
        longDescriptionView.addSubview(longDescriptionLabel)
        longDescriptionLabel.text = job.jobDescriptionBody
        longDescriptionLabel.numberOfLines = 2
        longDescriptionLabel.font = UIFont.systemFont(ofSize: 15)
        longDescriptionLabel.lineBreakMode = .byTruncatingTail
        longDescriptionLabel.semanticContentAttribute = .forceRightToLeft
        longDescriptionLabel.transform = CGAffineTransform(translationX: 0, y: -stndHeight)
        
        let longDescriptionExpansionButton = UIButton(frame: CGRect(x: 0, y: 0 , width: stndWidth/4 , height: stndHeight/2))
        longDescriptionExpansionButton.setTitle("קרא עוד", for: .normal)
        longDescriptionExpansionButton.setTitleColor(.black, for: .normal)
        longDescriptionExpansionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        longDescriptionExpansionButton.addTarget(self, action: #selector(expandLongDescription(_:)), for: .touchUpInside)
        
        
        mapViewerContainer = UIView(frame: CGRect(x: 0, y: subView.frame.maxY + stndHeight * 2 , width: stndWidth, height: stndHeight * 8))
        mapViewerContainer.backgroundColor = .white
        let mapViewer = MapForJobViewCutout(frame: CGRect(x: 0, y: 0 , width: stndWidth, height: stndHeight * 5))
        scrollView.addSubview(mapViewerContainer)
        mapViewerContainer.addSubview(mapViewer)
        //mapViewer.backgroundColor = .white
        mapViewerContainer.addSubview(longDescriptionExpansionButton)
        
        bottomViewContainer = UIView(frame: CGRect(x: 0, y:  mapViewer.frame.height - stndHeight + 5, width: stndWidth, height: stndHeight - 5 ))
        bottomViewContainer.alpha = 0.8
        
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: stndWidth, height: stndHeight - 5))
        bottomView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        distanceLabel = UILabel(frame: CGRect(x: 5, y: 0, width: stndWidth/2, height: stndHeight - 5))
        CLGeocoder().geocodeAddressString(job.jobLocation) { (placemarks , error) in
            if error == nil {
            let jobLocation = placemarks![0].location
            self.distance = jobLocation?.distance(from: UtilityService.mapManager.location!)
            self.distanceLabel.text =  String(Int(self.distance!/1000)) + " ק״מ ממני "
            } else {
                print(error.debugDescription)
            }
            //self.mapView.setCamera(MKMapCamera(lookingAtCenter: self.mapManager.location!.coordinate , fromDistance: self.distance * 2 , pitch: 0, heading: 0), animated: true)
        }
        
        
        distanceLabel.textColor = .white
        distanceLabel.textAlignment = .left
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let adressLabel = UIButton()
        adressLabel.setTitle( job.jobLocation , for: .normal)
        adressLabel.setTitleColor(.white, for: .normal)
        adressLabel.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        adressLabel.imageView?.tintColor = .white
        adressLabel.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        adressLabel.contentHorizontalAlignment = .right
        adressLabel.semanticContentAttribute = .forceRightToLeft
        
        bottomViewContainer.addSubview(bottomView)
        bottomView.addSubview(distanceLabel)
        bottomView.addSubview(adressLabel)
        
        
        
        mapViewer.addSubview(mapView)
        UtilityService.utlt.constrainEquallyWithinVoid(mapViewer, mapView, 0, false)
        mapViewer.addSubview(bottomViewContainer)
        
        UtilityService.utlt.constrainWithinSpecificVoid(adressLabel, bottomView.topAnchor, 0, distanceLabel.trailingAnchor, 0, bottomView.trailingAnchor, -5 , bottomView.bottomAnchor, 0)
        
        let bottomJobStackMenu = UIStackView(frame: CGRect(x: 0, y: mapViewer.frame.height , width: stndWidth, height: stndHeight * 3))
        bottomJobStackMenu.backgroundColor = .white
        bottomJobStackMenu.distribution = .fillEqually
        mapViewerContainer.addSubview(bottomJobStackMenu)
        
        var bottomJobMenuButtons = [CustomContactButton]()
        for i in 0...3 {
            let contactButton = CustomContactButton()
            //contactButton.backgroundColor = UIColor(hue: CGFloat.random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
            bottomJobMenuButtons.append(contactButton)
            bottomJobStackMenu.addArrangedSubview(bottomJobMenuButtons[i])
            
            let image = UIImageView(frame: CGRect(x: (stndWidth/4 - stndHeight * 1.5 )/2 , y: 0, width: stndHeight * 1.5 , height: stndHeight * 1.5 ))
            bottomJobMenuButtons[i].customImage = image
            let label = UILabel(frame: CGRect(x: 0, y: stndHeight * 1.5 , width: stndWidth/4 , height: stndHeight))
            bottomJobMenuButtons[i].customLabel = label
            switch i {
            case 0:
            image.image = UIImage(systemName: "trash.circle")
            label.text = "הסתר ג׳וב"
                break
            case 1:
                image.image = UIImage(systemName: "square.and.arrow.up.circle")
                label.text = "שתף עם חברים"
                break
            case 2:
                image.image = UIImage(systemName: "briefcase.circle")
                label.text = "ג׳ובים נוספים למעסיק זה"
                break
            case 3:
                image.image = UIImage(systemName: "star.circle")
                label.text = "הוסף למועדפים"
                break
            default:
                break
            }
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14)
            //label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 2
            label.textColor = UtilityService.cnfg.BrandOrange
            image.tintColor = UtilityService.cnfg.BrandOrange
            bottomJobMenuButtons[i].addSubview(image)
            bottomJobMenuButtons[i].addSubview(label)
            bottomJobMenuButtons[i].imageView?.contentMode = .scaleAspectFit
            bottomJobMenuButtons[i].transform = CGAffineTransform(scaleX: 0.85, y: 0.8)
            bottomJobMenuButtons[i].addTarget(self, action: #selector(contactButtonClick(_:)), for: .touchDown)
        }
        
        bottomVisualDecorationUnderview = PageUnderView(frame: CGRect(x: 0, y: mapViewerContainer.frame.maxY - 2 , width: stndWidth, height: stndHeight ))
        bottomVisualDecorationUnderview.backgroundColor = UtilityService.cnfg.BrandWhite
        scrollView.addSubview(bottomVisualDecorationUnderview)
        
        let exitX = UIButton(frame: CGRect(x: 10, y: 10, width: 15, height: 15))
        exitX.setImage(UIImage(systemName:"xmark"), for: .normal)
        exitX.imageView?.tintColor = .white
        scrollView.addSubview(exitX)
        exitX.addTarget(self, action: #selector(exit), for: .touchUpInside)
    }
    
    @objc func exit(){
        dismiss(animated: true)
    }
    
    @objc func contactButtonClick (_ sender:CustomContactButton) {
        sender.customLabel.textColor = .black
        sender.customImage.tintColor = .black
        UIWindow.animate(withDuration: 0.3, delay: 0) {
            sender.customLabel.textColor = UtilityService.cnfg.BrandOrange
            sender.customImage.tintColor = UtilityService.cnfg.BrandOrange
        } completion: { Bool in
            switch sender.index {
            case 0:
                print(self.job.jobEmailAdress!)
                break
            case 1:
                print(self.job.jobMessage!)
                break
            default:
                print(self.job.jobPhone!)
                break
              }
           }
        }
    
    
    @objc func expandLongDescription (_ sender:UIButton) {
        UIWindow.animate(withDuration: 0.3, delay: 0) {
            sender.alpha = 0
            self.longDescriptionLabel.transform = CGAffineTransform.identity
            self.mapViewerContainer.transform = CGAffineTransform(translationX: 0, y: self.stndHeight * 2 )
            self.bottomVisualDecorationUnderview.transform = CGAffineTransform(translationX: 0, y: self.stndHeight * 2)
        } completion: { Bool in
            self.longDescriptionLabel.numberOfLines = 0
            self.longDescriptionLabel.lineBreakMode = .byWordWrapping
            self.longDescriptionLabel.adjustsFontSizeToFitWidth = true
            if self.job.jobImage != nil {
                self.scrollView.contentSize = CGSize(width: self.view.bounds.width , height: self.stndHeight * 20 * 1.35)
            } else {
                self.scrollView.contentSize = CGSize(width: self.view.bounds.width , height: self.stndHeight * 20 * 1.1 )
            }
        }
    }
}


class CustomContactButton : UIButton {
    var customLabel : UILabel!
    var customImage : UIImageView!
    var index : Int!
}

extension JobViewPage : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            // create view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            // assign
            annotationView?.annotation = annotation
        }
        
        //set custom annotation image
        let imageView = UIImageView(image: job.jobType.image)
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        imageView.tintColor = .white
        imageView.backgroundColor = parentJobView.innerCell.backgroundColor
        imageView.layer.cornerRadius = (imageView.bounds.height)/2
        annotationView?.addSubview(imageView)
        annotationView?.backgroundColor = UtilityService.cnfg.BrandOrange
        
        
        
        return annotationView
    }
}
