import UIKit
import CoreLocation

class Job {
    
    var companyName : String
    var branchName : String?
    var jobType : JobType
    var jobTitle : String
    var jobDescriptionTitle : String
    var jobDescriptionBody : String
    var jobLocation : String
    var jobRawLocation : CLLocationCoordinate2D!
    var jobImage : UIImage?
    var jobQuestion: String?
    var jobQuestionDesiredAnswer: Bool?
    var color : UIColor?
    var jobPhone : String?
    var jobMessage : String?
    var jobEmailAdress : String?
    
    init(companyName: String, branchName: String?, jobType: JobType, jobDescriptionTitle: String,
         jobDescriptionBody: String, jobLocation: String, jobImage: UIImage?, jobQuestion: String?, jobQuestionDesiredAnswer: Bool?, jobPhone: String, jobMessage: String, jobEmailAdress: String){
        self.companyName = companyName
        self.branchName = branchName
        self.jobType = jobType
        self.jobTitle = (companyName + " מחפשת " + jobType.name)
        self.jobDescriptionTitle = jobDescriptionTitle
        self.jobDescriptionBody = jobDescriptionBody
        self.jobLocation = jobLocation
        self.jobImage = jobImage
        self.jobQuestion = jobQuestion
        self.jobQuestionDesiredAnswer = jobQuestionDesiredAnswer
        self.jobPhone = jobPhone
        self.jobMessage = jobMessage
        self.jobEmailAdress = jobEmailAdress
        self.color = UtilityService.randomColorGenerator.produceColor()
    }
    
        convenience init(random: Bool = false) {
            if random {
                self.init(companyName: Configuration().companyNames.randomElement()!, branchName: nil, jobType: JobType.init(random: true), jobDescriptionTitle: Configuration().titleCollection.randomElement()! , jobDescriptionBody: Configuration().descriptionCollection.randomElement()!, jobLocation: Configuration().jobLocations.randomElement()!, jobImage: Configuration().jobImages.randomElement() ?? nil , jobQuestion: nil, jobQuestionDesiredAnswer: nil, jobPhone: Configuration().phoneNumbers.randomElement()!, jobMessage: Configuration().phoneNumbers.randomElement()!, jobEmailAdress: Configuration().emailAdresses.randomElement()!)
                    jobTitleFromNameAndType(self)
            } else {
                self.init(companyName: "", branchName: "", jobType: JobType(random: true), jobDescriptionTitle: "", jobDescriptionBody: "", jobLocation: "", jobImage: nil, jobQuestion: nil, jobQuestionDesiredAnswer: nil, jobPhone: "", jobMessage: "", jobEmailAdress: "")
            }
        }
    
    func jobTitleFromNameAndType (_ job:Job) {
        job.jobTitle = (job.companyName + " מחפשת " + job.jobType.name)
    }
}

class JobType {
    var name: String
    var image: UIImage
  
    init(name: String, image: UIImage){
        self.name = name
        self.image = image
    }
    
    convenience init(random: Bool = false) {
        if random {
            self.init(name: Configuration().jobTypes.randomElement()!,image: UIImage(systemName: Configuration().IconCollection.randomElement()!)!)
        } else {
            self.init(name: "", image: UIImage(named: "UserImage")! )
        }
    }
    
      
}

class JobData {
    
    var allJobs = [Job]()
    
    @discardableResult func createJob() -> Job {
        
        let newJob = Job(random: true)
        
        allJobs.append(newJob)
        
        return newJob
    }
    
    var allJobTypes = [JobType]()
    
    @discardableResult func createJobType(_ index:Int) -> JobType {
        
        let newJobType = JobType(name: Configuration().jobTypes[index], image:UIImage(systemName: Configuration().IconCollection.randomElement()!)! )
        
        allJobTypes.append(newJobType)
        
        return newJobType
    }
    
    init() {
        for i in 0..<35 {
            createJobType(i)
        }
        for _ in 0..<10 {
           createJob()
        }
    }
    
    var subscribers = [jobDataDelegate]()
    
    func subscribe(_ delegate: jobDataDelegate) {
        subscribers.append(delegate)
    }
    
    func updateData () {
        for subscriber in subscribers {
            subscriber.onJobDataUpdated(self)
        }
    }
    
    func updateUnpublishedJobData (){
        for subscriber in subscribers {
            subscriber.onUnpublishedJobUpdated(self)
        }
    }
}


protocol jobDataDelegate {
    func onJobDataUpdated (_ jobData: JobData)
    func onUnpublishedJobUpdated (_ jobData: JobData)
}
