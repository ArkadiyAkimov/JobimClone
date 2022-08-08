import UIKit

class PublishJobTypeOfJobVC: SimpleViewController, UINavigationBarDelegate ,UITableViewDelegate, UITableViewDataSource, jobDataDelegate {
    func onJobDataUpdated(_ jobData: JobData) {
        
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
        if selectedJobTypeIndex != nil{ UtilityService.unpublishedJob.jobType = AppDataService.jobRepository.allJobTypes[selectedJobTypeIndex] }
    }
    
    var topCover : UIView!

    var cellHeight = Configuration().barHeight * 1.3
    var publishJobPage : PublishJobVC!
    var randomColor = RandomColorGenerator()
    
    var selectedJobTypeIndex : Int!
    var radioButtons = [UIButton]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDataService.jobRepository.subscribe(self)
        view.backgroundColor = .clear
        
            //tableView.separatorStyle = .none
            //tableView.isScrollEnabled = false
            tableView.dataSource = self
            tableView.delegate = self
            tableView.contentMode = .center
            tableView.backgroundColor = UtilityService.cnfg.BrandWhite
            
            self.view.addSubview(tableView)
        UtilityService.utlt.constrainEquallyWithinVoid(view, tableView, 0, true)
            tableView.frame = view.bounds
            
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppDataService.jobRepository.allJobTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
            let jobImage = UIImageView(frame: CGRect(x: 10, y: 0, width: cellHeight , height: cellHeight ))
            jobImage.image = AppDataService.jobRepository.allJobTypes[indexPath.row].image
            jobImage.tintColor = randomColor.produceColor()
            cell.addSubview(jobImage)
            
            radioButtons.append(UIButton())
            radioButtons[indexPath.row] = UIButton(frame: CGRect(x: view.frame.width - cellHeight , y: 0, width: cellHeight , height: cellHeight ))
            radioButtons[indexPath.row].layer.borderWidth = 4
            radioButtons[indexPath.row].layer.borderColor = UIColor.lightGray.cgColor
            radioButtons[indexPath.row].layer.cornerRadius = cellHeight/2
            radioButtons[indexPath.row].transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
            cell.addSubview(radioButtons[indexPath.row])
            
            let jobName = UILabel()
            jobName.text = AppDataService.jobRepository.allJobTypes[indexPath.row].name
            jobName.semanticContentAttribute = .forceRightToLeft
            
            cell.addSubview(jobName)
            UtilityService.utlt.constrainWithinSpecificVoid(jobName, cell.topAnchor, 0, jobImage.trailingAnchor, 0, radioButtons[indexPath.row].leadingAnchor , 0, cell.bottomAnchor, 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        radioButtons[indexPath.row].backgroundColor = UtilityService.cnfg.BrandOrange
        selectedJobTypeIndex = indexPath.row
        publishJobPage.nextSegmentedIndex()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        radioButtons[indexPath.row].backgroundColor = UtilityService.cnfg.BrandWhite
    }
}


