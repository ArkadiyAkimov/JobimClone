import UIKit

class FilterData {

    var subscribers = [filterDelegate]()
    var jobTypesIndexes = [Bool]()
    var searchedJobs = [Job]()
    var isFilteredGlobal = false

    @discardableResult func createJobTypeIndex() -> Bool {
        let newJobTypeIndex = false
        jobTypesIndexes.append(newJobTypeIndex)
        return newJobTypeIndex
    }

    init() {
        for _ in 0..<35 {
            createJobTypeIndex()
        }
    }

    func subscribe(_ delegate: filterDelegate) {
        subscribers.append(delegate)
    }

    func isFilteredCheck(){
        var isFiltered = false
        AppDataService.filterRepository.jobTypesIndexes.forEach { Bool in
            if Bool { isFiltered = true
            }
        }
        if isFiltered { isFilteredGlobal = true }
        else { isFilteredGlobal = false }
    }
    
    func mainProcess(){
        isFilteredCheck()
        if isFilteredGlobal {
            updateSearchedJobs()
        }
        updateSearchConditions()
        AppDataService.jobRepository.updateData()
    }
    
    func updateSearchedJobs(){
        searchedJobs.removeAll()
        print("searchedJobs: " + String(searchedJobs.count))
        AppDataService.jobRepository.allJobs.forEach { Job in
            for i in 0..<jobTypesIndexes.count{
                if Job.jobType.name == AppDataService.jobRepository.allJobTypes[i].name && jobTypesIndexes[i] {
                    print(Job.jobTitle);
                    searchedJobs.append(Job);
                }
            }
        }
        print("searchedJobs : \(searchedJobs.count)")
    }

    func updateSearchConditions (){
        for subscriber in subscribers {
            subscriber.onUpdatedSearchConditions(self)
        }
    }

}

protocol filterDelegate {
    func onUpdatedSearchConditions(_ filterData: FilterData)
}
