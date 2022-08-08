import UIKit

class JobBrowserVC : UIViewController , UITableViewDelegate, UITableViewDataSource, jobDataDelegate, filterDelegate {
    
    let cnfg = Configuration()
    let utlt = UtilityService()
    var randomColorGen = RandomColorGenerator()
    var jobSource : [Job]!
    var jobViews = [JobView]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDataService.jobRepository.subscribe(self)
        AppDataService.filterRepository.subscribe(self)
        view.backgroundColor = .clear
            
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = cnfg.BrandWhite
        view.addSubview(tableView)
        UtilityService.utlt.constrainEquallyWithinVoid(view, tableView, 0, false)
        tableView.frame = view.frame
        
        
        jobSource = AppDataService.jobRepository.allJobs
        createJobViews()
        
       }
    
    func onUpdatedSearchConditions(_ filterData: FilterData) {
        if AppDataService.filterRepository.isFilteredGlobal {
            jobSource = AppDataService.filterRepository.searchedJobs
            print("source: filter")
        }
        else {
            jobSource = AppDataService.jobRepository.allJobs
            print("source: jobs")
        }
    }
    
    func onJobDataUpdated(_ jobData: JobData) {
        createJobViews()
        print("jobviews: " + String( jobViews.count))
        tableView.reloadData()
    }
    
    func onUnpublishedJobUpdated(_ jobData: JobData) {
    }
    
    @objc func pushToPage(){
       print("page")
    }
    
    func createJobViews(){
    jobViews.removeAll()
    for i in 0..<jobSource.count {
    jobViews.append(JobView())
    jobViews[i].jobSource = jobSource
    jobViews[i].jobIndex = i
    jobViews[i].jobPage.parentJobView = jobViews[i]
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(jobViews[indexPath.row].jobPage, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobViews.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if jobSource[indexPath.row].jobImage == nil {
          return 180
        } else {
        return 270
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.selectionStyle = .none
        
        let jobView = jobViews[indexPath.row]
        jobView.randomColorGenerator = randomColorGen
        jobView.cell = cell
        cell.addSubview(jobView)
        UtilityService.utlt.constrainEquallyWithinVoid(cell, jobView, 0, false)
        
        return cell
    }

    func loadAnimation () {
        self.view.alpha = 1
        self.view.transform = CGAffineTransform(translationX:  -view.bounds.width , y: 0)
        UIView.animate(withDuration: 0.5) {
        //self.view.transform = CGAffineTransform(a: 2, b: 0, c: 1.4, d: 2, tx: 1, ty: 0)
        self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    func dismissAnimation () {
        self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        UIView.animate(withDuration: 0.5) {
            //self.view.transform = CGAffineTransform(a: 1, b: 0, c: 1.4, d: 2, tx: 1, ty: 0)
            self.view.transform = CGAffineTransform(translationX: -self.view.bounds.width , y: 0)
        } completion: { Bool in
            self.view.alpha = 0
        }
    }
    
}
