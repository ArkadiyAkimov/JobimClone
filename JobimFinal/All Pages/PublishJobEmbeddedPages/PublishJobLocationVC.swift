import UIKit
import MapKit

class PublishJobLocationVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, jobDataDelegate {
    func onJobDataUpdated(_ jobData: JobData) {
        
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
        UtilityService.unpublishedJob.jobLocation = locationInfoLabel.text!
        UtilityService.unpublishedJob.jobRawLocation = locationData
    }
    
    var topCover : UIView!
    var locationInfoLabel = UILabel()
    var locationData = CLLocationCoordinate2D()
    
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
            label.text = "מיקום הג׳וב"
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.preferredFont(forTextStyle: .body)
            cell.addSubview(label)
            break
        case 1:
            let companyName = UIView(frame: CGRect(x: 20, y: 0, width: cell.frame.width - 40, height: cell.frame.height))
            companyName.backgroundColor = UtilityService.cnfg.BrandLightGray
            companyName.layer.cornerRadius = 5
            locationInfoLabel = UILabel()
            locationInfoLabel.semanticContentAttribute = .forceRightToLeft
            companyName.addSubview(locationInfoLabel)
            CLGeocoder().reverseGeocodeLocation(UtilityService.mapManager.location!, preferredLocale: .current ) { (placemarks, error) in
                let placemark = placemarks![0]
                self.locationInfoLabel.text = placemark.name! + ", " + placemark.locality!
                self.locationData = placemarks![0].location!.coordinate
            }
            
            UtilityService.utlt.constrainEquallyWithinVoid(companyName, locationInfoLabel, 20, false)
            cell.addSubview(companyName)
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



