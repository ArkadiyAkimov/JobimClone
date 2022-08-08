import UIKit
import CoreLocation

class JobView : UIButton {
    let utlt = UtilityService()
    
    var randomColorGenerator : RandomColorGenerator!
    var innerCell = UIView()
    
    var titleImageView : UIImageView!
    var jobPage = JobViewPage()
    var jobIndex : Int!
    var cell : UITableViewCell!
    var distanceLabel : UILabel!
    var distance : CLLocationDistance!
    var jobSource : [Job]!
    
    override func layoutSubviews() {
         super.layoutSubviews()
        innerCell = UIButton(frame: CGRect(x: 10, y: 0, width: cell.frame.width - 20, height: cell.frame.height - 10))
        let job = jobSource[jobIndex]
        addSubview(innerCell)
        
        innerCell.backgroundColor = jobSource[jobIndex].color
        jobPage.view.backgroundColor = innerCell.backgroundColor
        jobPage.bottomViewContainer.backgroundColor = innerCell.backgroundColor
        
        
        let stndHeight = UtilityService.cnfg.barHeight - 10
        let stndWidth = innerCell.frame.width
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: stndWidth , height: stndHeight ))
        titleLabel.text = job.jobTitle
        
        titleLabel.textAlignment = .center
        titleLabel.clipsToBounds = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        let titleImage = UIView(frame: CGRect(x: 0, y: stndHeight , width: stndWidth , height: stndHeight * 2))
        titleImageView = UIImageView(image: job.jobType.image)
        titleImageView.frame = CGRect(x: cell.frame.width/2 - 40 , y: 0, width: stndHeight * 2, height: stndHeight * 2)
        
        titleImageView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.5)
        titleImageView.layer.masksToBounds = false
        
        titleImageView.layer.cornerRadius = stndHeight
        
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.clipsToBounds = true
        titleImageView.tintColor = .white
        
        titleImage.addSubview(titleImageView)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: stndHeight * 3, width: innerCell.frame.width, height: stndHeight ))
        subtitleLabel.text = job.jobDescriptionTitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .white
        subtitleLabel.transform = CGAffineTransform(scaleX: 0.95, y: 1)
        subtitleLabel.font = UIFont.systemFont(ofSize: 18)
        
        
        if job.jobImage != nil {
        let largerImage = JobBrowserImageCutout(frame: CGRect(x: 0, y: stndHeight * 4 , width: stndWidth, height: stndHeight * 3))
        largerImage.image = job.jobImage
        largerImage.contentMode = .scaleAspectFill
        largerImage.clipsToBounds = true
        innerCell.addSubview(largerImage)
        }
            
        let bottomViewContainer = UIView(frame: CGRect(x: 0, y:  innerCell.frame.height - stndHeight + 5, width: stndWidth, height: stndHeight - 5 ))
        bottomViewContainer.backgroundColor = innerCell.backgroundColor
        
        let bottomView = UIView(frame: CGRect(x: 0, y: 0, width: stndWidth, height: stndHeight - 5))
        bottomView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        distanceLabel = UILabel(frame: CGRect(x: 5, y: 0, width: stndWidth/3, height: stndHeight - 5))
        
        CLGeocoder().geocodeAddressString(job.jobLocation) { (placemarks , error) in
            if error == nil {
            let jobLocation = placemarks![0].location
            self.distance = jobLocation?.distance(from: UtilityService.mapManager.location!)
            self.distanceLabel.text =  String(Int(self.distance!/1000)) + " ק״מ ממני "
            } else {
                print(error!)
            }
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
        
        innerCell.addSubview(titleLabel)
        innerCell.addSubview(titleImage)
        innerCell.addSubview(subtitleLabel)
        innerCell.addSubview(bottomViewContainer)
        
        bottomViewContainer.addSubview(bottomView)
        bottomView.addSubview(distanceLabel)
        bottomView.addSubview(adressLabel)
      
        UtilityService.utlt.constrainWithinSpecificVoid(adressLabel, bottomView.topAnchor, 0, distanceLabel.trailingAnchor, 0, bottomView.trailingAnchor, -5 , bottomView.bottomAnchor, 0)
    }
}
